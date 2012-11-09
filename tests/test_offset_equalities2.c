#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "bitvectors.h"
#include "memalloc.h"
#include "offset_equalities.h"

#ifdef MINGW
static inline long int random(void) {
  return rand();
}
#endif



/*
 * TABLE OF POLYNOMIALS
 */

/*
 * - poly[0] is not used
 * - poly[i] may be NULL (this means that xi is a variable)
 *   or poly[i] is a polynomial that depend on variables with index < i
 * - vars = array of all indices such that poly[i] = NULL
 */
typedef struct poly_table_s {
  uint32_t psize;    // size of the poly array
  uint32_t npolys;   // current number of elements in poly (i.e., poly[1 ... npolys-1] are defined)
  polynomial_t **poly;

  uint32_t vsize;    // size of the var arrey
  uint32_t nvars;     // number of variabels stored in vars
  int32_t *var;  
} poly_table_t;

#define MAX_PSIZE (UINT32_MAX/sizeof(polynomial_t *))
#define MAX_VSIZE (UINT32_MAX/sizeof(int32_t))



/*
 * Initialize: np = initial psize, nv = initial vsize
 */
static void init_poly_table(poly_table_t *table, uint32_t np, uint32_t nv) {
  assert(0 < np && np <= MAX_PSIZE && nv <= MAX_VSIZE);

  table->psize = np;
  table->npolys = 1;
  table->poly = (polynomial_t **) safe_malloc(np * sizeof(polynomial_t *));
  table->poly[0] = NULL; // not used
    
  table->vsize = nv;
  table->nvars = 0;
  table->var = (int32_t *) safe_malloc(nv * sizeof(int32_t));
}


/*
 * Increase the array's sizes
 */
static void make_room_for_polys(poly_table_t *table) {
  uint32_t n;

  n = 2 * table->psize;
  if (n > MAX_PSIZE) {
    out_of_memory();
  }
  table->poly = (polynomial_t **) safe_realloc(table->poly, n * sizeof(polynomial_t *));
  table->psize  = n;
}

static void make_room_for_vars(poly_table_t *table) {
  uint32_t n;

  n = 2 * table->vsize;
  if (n > MAX_VSIZE) {
    out_of_memory();
  }
  table->var = (int32_t *) safe_realloc(table->var, n * sizeof(int32_t));
  table->vsize = n;
}


/*
 * Add i to the variable array
 */
static void add_var(poly_table_t *table, int32_t i) {
  uint32_t j;

  j = table->nvars;
  if (j == table->vsize) {
    make_room_for_vars(table);
  }
  assert(j < table->vsize);
  table->var[j] = i;
  table->nvars = j+1;
}

/*
 * Add polynomial p to the table
 * - stores p in table->poly[i].
 * - if p is NULL, also add i to the variable array
 */
static void add_poly(poly_table_t *table, polynomial_t *p) {
  uint32_t i;

  i = table->npolys;
  if (i == table->psize) {
    make_room_for_polys(table);
  }
  assert(i < table->psize);
  table->poly[i] = p;
  table->npolys = i+1;

  if (p == NULL) {
    add_var(table, i);
  }
}


/*
 * Delete the arrays
 */
static void delete_poly_table(poly_table_t *table) {
  polynomial_t *p;
  uint32_t i, n;

  n = table->npolys;
  for (i=1; i<n; i++) {
    p = table->poly[i];
    if (p != NULL) {
      free_polynomial(p);
    }
  }

  safe_free(table->poly);
  safe_free(table->var);
  table->poly = NULL;
  table->var = NULL;
}




/*
 * RANDOM POLYNOMIALS
 */

/*
 * - coeff[0 .. NCOEFF] define the coefficients and their distribution
 * - nterms[0 .. NTERMS] define the number of terms 
 * - constant[0 .. NCONST]: constant parts
 * - we favor small polynomials with coefficients +1/-1
 */

#define NCOEFF 20
#define NTERMS 10
#define NCONST 40

static const int32_t coeff[NCOEFF] = {
  1, 1, 1, 1, 
  -1, -1, -1, -1, 
  2, 2, -2, -2,
  3, 4, 7, 8,
  -3, -4, -7, -8,
};

static const uint32_t nterms[NTERMS] = {
  1, 1, 2, 2, 2,
  3, 3, 3, 10, 20,
};

static const int32_t constant[NCONST] = {
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
  0, -1, -2, -3, -4, -5, -6, -7, -8. -9,
  0, 0, 0, 10, 20, 30, 40, 50, 100, 200,
  0, 0, 0, -10, -20, -30, -40, -50, -100, -200,
};


// random integer in [0 ... n-1]
static inline uint32_t random_index(uint32_t n) {
  assert(n > 0);
  return ((uint32_t) random()) % n;
}

static inline int32_t random_coeff(void) {
  return coeff[random_index(NCOEFF)];
}

static inline uint32_t random_nterms(void) {
  return nterms[random_index(NTERMS)];
}

static inline int32_t random_constant(void) {
  return constant[random_index(NCONST)];
}


/*
 * Random variable in table
 */
static inline int32_t random_var(poly_table_t *table) {
  return table->var[random_index(table->nvars)];
}


/*
 * Random polynomial:
 * - use variables defined in table
 */
static polynomial_t *random_poly(poly_buffer_t *b, poly_table_t *table) {
  rational_t q;
  uint32_t i, n;
  int32_t x, a;

  q_init(&q);
  reset_poly_buffer(b);

  a = random_constant();
  q_set32(&q, a);
  poly_buffer_add_const(b, &q);
  
  n = random_nterms();
  for (i=0; i<n; i++) {
    a = random_coeff();
    x = random_var(table);
    assert(x > 0);

    q_set32(&q, a);
    poly_buffer_add_monomial(b, x, &q);
  }

  normalize_poly_buffer(b);
  q_clear(&q);

  return poly_buffer_get_poly(b);
}


/*
 * Fill table with random polys:
 * - nvars = number of initial variables (must be positive)
 *   poly[1 ... nvars] will all be variables
 * - n = total number of polynomials to build (including nvars)
 */
static void build_poly_table(poly_table_t *table, uint32_t nvars, uint32_t n) {
  poly_buffer_t buffer;
  polynomial_t *p;
  uint32_t i;

  for (i=0; i<nvars; i++) {
    add_poly(table, NULL);
  }

  init_poly_buffer(&buffer);

  while (i<n) {
    p = NULL;
    if (random_index(10) != 0) {
      p = random_poly(&buffer, table);
    }
    add_poly(table, p);
    i ++;
  }

  delete_poly_buffer(&buffer);
}



/*
 * SUBSTITUTIONS
 */

/*
 * To double check the offset manager results, we store a variable
 * substitution in the following data structure.
 * - subst->size = an upper bound on the actual number of varibles
 * - subst->elim[x] = true if x is mapped to (y + k) in the substitution
 * - subst->var[x] = the variable y
 * - subst->delta[x] = the constant k
 *
 * Special encoding: mapping x := k is stored by setting var[x] = -1, delta[x] = k
 */
typedef struct substitution_s {
  uint32_t size;
  uint8_t *elim;
  int32_t *var;
  int32_t *delta;
} substitution_t;

#define MAX_SUBSTITUTION_SIZE (UINT32_MAX/sizeof(int32_t))


/*
 * Pair variable, offset (result of substitution applied to an x)
 */
typedef struct offset_pair_s {
  int32_t var;
  int32_t delta;
} offset_pair_t;


/*
 * Offset equality descriptor: for x = y + offset
 */
typedef struct offset_equality_s {
  int32_t lhs; // x
  int32_t rhs; // y
  int32_t offset;
} offset_equality_t;



/*
 * Initialize for n variables
 */
static void init_substitution(substitution_t *s, uint32_t n) {
  uint32_t i;

  assert(n <= MAX_SUBSTITUTION_SIZE);

  s->size = n;
  s->elim = (uint8_t *) safe_malloc(n * sizeof(uint8_t));
  s->var = (int32_t *) safe_malloc(n * sizeof(int32_t));
  s->delta = (int32_t *) safe_malloc(n * sizeof(int32_t));

  for (i=0; i<n; i++) {
    s->elim[i] = false;
  }
}


/*
 * Delete
 */
static void delete_substitution(substitution_t *s) {
  safe_free(s->elim);
  safe_free(s->var);
  safe_free(s->delta);
  s->elim = NULL;
  s->var = NULL;
  s->delta = NULL;
}


/*
 * Add x := y + k to s
 * - x must not be mapped already
 */
static void add_subst(substitution_t *s, int32_t x, int32_t y, int32_t k) {
  assert(0 < x && x < s->size && 0 < y && y < s->size && !s->elim[x]);
  s->elim[x] = true;
  s->var[x] = y;
  s->delta[x] = k;
}


/*
 * Remove the mapping of x
 */
static void remove_subst(substitution_t *s, int32_t x) {
  assert(0 < x && x < s->size && s->elim[x]);
  s->elim[x] = false;
}



/*
 * Apply the subsitution to a pair d = x + k
 */
static void subst_var(substitution_t *s, offset_pair_t *d) {
  uint32_t n;
  int32_t x;
  int32_t k;

  n = s->size; // to detect circularities
  
  x = d->var;
  k = d->delta;

  while (x >= 0 && s->elim[x]) {
    k += s->delta[x];
    x = s->var[x];
    n --;
    if (n == 0) goto bug;      
  }

  d->var = x;
  d->delta = k;

  return;

 bug:
  fprintf(stderr, "*** BUG: circular substitution detected ***\n");
  exit(1);
}


/*
 * Apply s to an offset equality x = y + offset
 */
static void subst_eq(substitution_t *s, offset_equality_t *e) {
  offset_pair_t aux1, aux2;

  aux1.var = e->lhs;
  aux1.delta = 0;
  subst_var(s, &aux1);

  aux2.var = e->rhs;
  aux2.delta = 0;
  subst_var(s, &aux2);

  e->lhs = aux1.var;
  e->rhs = aux2.var;
  e->offset -= aux1.delta;
  e->offset += aux2.delta;
}


/*
 * Apply s to a monomial array mono
 * - store the result in buffer b
 */
static void subst_poly(substitution_t *s, poly_buffer_t *b, monomial_t *mono) {
  offset_pair_t aux;
  rational_t q;
  int32_t x;

  q_init(&q);
  reset_poly_buffer(b);  

  x = mono->var;
  while (x != max_idx) {
    if (x == const_idx) {
      poly_buffer_add_const(b, &mono->coeff);
    } else {
      aux.var = x;
      aux.delta = 0;
      subst_var(s, &aux); // aux constains S[x] = y + delta

      // add a * y + a * delta to b
      if (aux.var > 0) {
	poly_buffer_add_monomial(b, aux.var, &mono->coeff);
      }
      q_set32(&q, aux.delta);
      poly_buffer_addmul_monomial(b, const_idx, &mono->coeff, &q);
    }
    mono ++;
    x = mono->var;
  }

  normalize_poly_buffer(b);
  q_clear(&q);
}


/*
 * Apply s to poly[i]
 * - store the result in buffer b
 */
static void subst_poly_idx(substitution_t *s, poly_table_t *table, poly_buffer_t *b, int32_t i) {  
  monomial_t aux[2];
  polynomial_t *p;
  
  assert(0 < i && i < table->npolys);
  p = table->poly[i];
  if (p == NULL) {
    // build the polynomial 1.i in aux
    aux[0].var = i;
    q_init(&aux[0].coeff);
    q_set_one(&aux[0].coeff);
    aux[1].var = max_idx;
    subst_poly(s, b, aux);
    q_clear(&aux[0].coeff);
  } else {
    subst_poly(s, b, p->mono);
  }
}



/*
 * NORMAL FORM OF A POLYNOMIAL
 */

/*
 * For a polynomial p and a subsitution s, the normal form of p is s(p)
 * - we store the result in the following structure:
 *   nterms = number of terms in s(p)
 *   mono   = the monmoials of s(p)
 *   hash   = hash code for the s(p)
 * - the size of array mono must be set to nterms(p) + 2 initially
 */
typedef struct normal_form_s {
  uint32_t hash;
  uint32_t nterms;
  uint32_t size;
  monomial_t mono[0];
} normal_form_t;


/* 
 * allocate a normal_form buffer with n monomials + one end marker
 * - the rational coefficients in mono[0 ... n-1] are all initialized
 * - mono[n] is allocated but not initialized
 */
static normal_form_t *new_normal_form(uint32_t n) {
  normal_form_t *tmp;
  uint32_t i;

  assert(n < 1000);

  tmp = (normal_form_t *) safe_malloc(sizeof(normal_form_t) + (n + 1) * sizeof(monomial_t));
  tmp->size = n;
  for (i=0; i<n; i++) {
    q_init(&tmp->mono[i].coeff);
  }

  return tmp;
}

static void free_normal_form(normal_form_t *tmp) {
  uint32_t i, n;

  n = tmp->size;
  for (i=0; i<n; i++) {
    q_clear(&tmp->mono[i].coeff);
  }
  safe_free(tmp);
}

/*
 * Copy the content of buffer b into f
 */
static void set_normal_form(normal_form_t *f, poly_buffer_t *b) {
  monomial_t *mono;
  uint32_t i, n;

  n = poly_buffer_nterms(b);
  mono = poly_buffer_mono(b);

  assert(n <= f->size);
  for (i=0; i<n; i++) {
    f->mono[i].var = mono[i].var;
    q_set(&f->mono[i].coeff, &mono[i].coeff);
  }
  f->mono[i].var = max_idx; // end marker

  f->nterms = n;
  f->hash = hash_monarray(f->mono, n);
}




/*
 * RESULTS FROM THE OFFSET MANAGER
 */

/*
 * The offset manager propagates equalities between two variables x and y
 * - both x and y are variables in a poly_table
 * - we store the equalities we get in a stack
 * - to mark backtracking point, we use a fake equality -1 == -1
 * - we also use a merge table to compute equivalence classes
 */
typedef struct equality_s {
  int32_t lhs;  // x
  int32_t rhs;  // y
} equality_t;

typedef struct equality_queue_s {
  uint32_t qsize;
  uint32_t top;
  equality_t *data;

  uint32_t nvars;
  int32_t *parent; // array of nvars elements
} equality_queue_t;

#define MAX_QSIZE (UINT32_MAX/sizeof(equality_t))



/*
 * Initialize the queue
 * - n = number of variables
 */
static void init_equality_queue(equality_queue_t *queue, uint32_t n) {
  uint32_t i;

  queue->qsize = 1000;
  queue->top = 0;
  queue->data = (equality_t *) safe_malloc(1000 * sizeof(equality_t));

  queue->nvars = n;
  queue->parent = (int32_t *) safe_malloc(n * sizeof(int32_t));
  for (i=0; i<n; i++) {
    queue->parent[i] = i;
  }
}


/*
 * Make room for more equalities
 */
static void extend_equality_queue(equality_queue_t *queue) {
  uint32_t n;

  n = 2 * queue->qsize;
  if (n > MAX_QSIZE) {
    out_of_memory();
  }

  queue->data = (equality_t *) safe_realloc(queue->data, n * sizeof(equality_t));
  queue->qsize = n;
}


/*
 * Delete
 */
static void delete_equality_queue(equality_queue_t *queue) {
  safe_free(queue->data);
  safe_free(queue->parent);
  queue->data = NULL;
  queue->parent = NULL;
}


/*
 * Root of x in queue->parent tree
 */
static int32_t root_of_var(equality_queue_t *queue, int32_t x) {
  int32_t p;

  do {
    assert(0 <= x && x < queue->nvars);
    p = x;
    x = queue->parent[x];
  } while (p != x);

  return p;
}


/*
 * Check whether x is a root in the equivalence classes
 */
static bool var_is_root(equality_queue_t *queue, int32_t x) {
  assert(0 <= x && x < queue->nvars);
  return queue->parent[x] == x;
}


/*
 * Add equality x == y to the queue:
 * - both x and y should be roots
 */
static void push_equality(equality_queue_t *queue, int32_t x, int32_t y) {
  uint32_t i;

  assert(var_is_root(queue, x) && var_is_root(queue, y));

  i = queue->top;
  if (i == queue->qsize) {
    extend_equality_queue(queue);
  }
  assert(i < queue->qsize);
  queue->data[i].lhs = x;
  queue->data[i].rhs = y;

  queue->top = i+1;  

  // update the parents: we always do lhs := rhs (so y stays root)
  // this is a no-op if x = y (as we want).
  queue->parent[x] = y;
}


/*
 * Add a backtrack mark to the queue
 */
static void push_mark(equality_queue_t *queue) {
  uint32_t i;

  i = queue->top;
  if (i == queue->qsize) {
    extend_equality_queue(queue);
  }
  assert(i < queue->qsize);
  queue->data[i].lhs = -1;
  queue->data[i].rhs = -1;
}


/*
 * Backtrack to the top-most mark
 * - if there's no mark, empty the queue
 */
static void equality_queue_backtrack(equality_queue_t *queue) {
  uint32_t i;
  int32_t x;

  i = queue->top;
  while (i > 0) {
    i --;
    x = queue->data[i].lhs;
    if (x < 0) {
      assert(queue->data[i].rhs < 0);
      break;
    }

    // restore parent of lhs
    assert(0 <= x && x < queue->nvars && queue->parent[x] == queue->data[i].rhs);
    queue->parent[x] = x;
  }

  queue->top = i;
}


/*
 * Call back: report that x and y are equal
 * - aux is a pointer to am equality queue
 * - x and y must be two variable indices in this table
 */
static void notify_equality(void *aux, int32_t x, int32_t y) {
  equality_queue_t *queue;

  queue = aux;
  assert(1 <= x && x <= queue->nvars && 0 <= y && y <= queue->nvars);
  printf("---> received equality: x%"PRId32" == x%"PRId32"\n", x, y);
  fflush(stdout);

  x = root_of_var(queue, x);
  y = root_of_var(queue, y);
  push_equality(queue, x, y);  
}



/*
 * TEST BENCH
 */

/*
 * Active polynomials:
 * - a polynomial i is active if it was added to the offset manager
 * - there are npolys active polynomials
 * - for each i in 0 ... npolys - 1
 * - id[i] = index in the relevant poly_table
 * - norm[i] = normal form for the polynomial
 * - also when we add activate polynomial k, we mark active[k] = true
 */
typedef struct active_poly_table_s {
  uint32_t size;   // size of arrays id and norm
  uint32_t npolys; // number of active polys stored
  int32_t *id;
  normal_form_t **norm;
  uint8_t *active;
} active_poly_table_t;

#define MAX_ACTIVE_POLYS (UINT32_MAX/sizeof(normal_form_t *))

// m = fixed size of the active poly table
static void init_active_polys(active_poly_table_t *table, uint32_t n) {
  uint32_t i;

  assert(n <= MAX_ACTIVE_POLYS);

  table->size = n;
  table->npolys = 0;
  table->id = (int32_t *) safe_malloc(n * sizeof(int32_t));
  table->norm = (normal_form_t **) safe_malloc(n * sizeof(normal_form_t *));
  table->active = (uint8_t *) safe_malloc(n * sizeof(uint8_t));

  for (i=0; i<n; i++) {
    table->active[i] = false;
  }
}

static void delete_active_polys(active_poly_table_t *table) {
  uint32_t i, n;

  n = table->npolys;
  for (i=0; i<n; i++) {
    free_normal_form(table->norm[i]);
  }
  safe_free(table->id);
  safe_free(table->norm);
  safe_free(table->active);
  table->id = NULL;
  table->norm = NULL;
  table->active = NULL;
}

static void add_active_poly(active_poly_table_t *table, poly_table_t *ptbl, int32_t i) {
  polynomial_t *p;
  normal_form_t *q;
  uint32_t k, n;

  assert(0 < i && i < ptbl->npolys && !table->active[i]);

  p = ptbl->poly[i];
  n = (p == NULL) ? 2 : (p->nterms + 1);
  q = new_normal_form(n);
  
  k = table->npolys;
  assert(k < table->size);
  table->id[k] = i;
  table->norm[k] = q;
  table->npolys = k + 1;

  table->active[i] = true;
}

static void remove_active_poly(active_poly_table_t *table) {
  uint32_t k;
  int32_t id;

  assert(table->npolys > 0);

  k = table->npolys - 1;
  free_normal_form(table->norm[k]);
  id = table->id[k];

  assert(table->active[id]);
  table->active[k] = false;

  table->npolys = k;
}


/*
 * Substitution queue
 * - to undo/update the substitution, we keep track of variable
 * - when we add x:= y + k to subst, we store x at the end of the variable queue
 */
typedef struct subst_queue_s {
  uint32_t size;
  uint32_t top;
  int32_t *data;
} subst_queue_t;

#define MAX_SQUEUE_SIZE (UINT32_MAX/sizeof(int32_t))

// n = fixed size
static void init_subst_queue(subst_queue_t *queue, uint32_t n) {
  assert(n <= MAX_SQUEUE_SIZE);
  queue->size = n;
  queue->top = 0;
  queue->data = (int32_t *) safe_malloc(n * sizeof(int32_t));
}

static void delete_subst_queue(subst_queue_t *queue) {
  safe_free(queue->data);
  queue->data = NULL;
}

static void subst_queue_push_var(subst_queue_t *queue, int32_t x) {
  uint32_t i;

  i = queue->top;
  assert(i < queue->size);
  queue->data[i] = x;
  queue->top = i+1;
}

static int32_t subst_queue_pop_var(subst_queue_t *queue) {
  assert(queue->top > 0);
  queue->top --;
  return queue->data[queue->top];
}


/*
 * Queue of test operations
 * - operations on offset_manager include
 *   record_poly
 *   assert_eq
 *   propagate
 *   push
 *   pop
 * - for testing we keep track of the sequence of operations
 *   performed (except push)
 * - desciptors for each operation:
 *   record_poly(i): activate polynomial of index i
 *  
 */
typedef enum operations {
  RECORD_POLY,
  ASSERT_EQ,
  PROPAGATE,
  PUSH,
} operation_t;

typedef struct op_desc_s {
  operation_t tag;
  union {
    int32_t rec_id;        // argument of RECORD_POLY
    offset_equality_t eq;  // argument of ASSERT_EQ
  } arg;
} op_desc_t;

typedef struct op_stack_s {
  uint32_t size;
  uint32_t top;
  op_desc_t *data;
} op_stack_t;

#define MAX_OP_STACK_SIZE (UINT32_MAX/sizeof(op_desc_t))

static void init_op_stack(op_stack_t *stack) {
  uint32_t n;

  n = 100;
  stack->size = n;
  stack->top = 0;
  stack->data = (op_desc_t *) safe_malloc(n * sizeof(op_stack_t));
}

static void extend_op_stack(op_stack_t *stack) {
  uint32_t n;

  n = stack->size * 2;
  if (n > MAX_OP_STACK_SIZE) {
    out_of_memory();
  }
  stack->size = n;
  stack->data = (op_desc_t *) safe_realloc(stack->data, n * sizeof(op_stack_t));
}

static void delete_op_stack(op_stack_t *stack) {
  safe_free(stack->data);
  stack->data = NULL;
}

static void push_record_poly(op_stack_t *stack, int32_t id) {
  uint32_t i;

  i = stack->top;
  if (i == stack->size) {
    extend_op_stack(stack);
  }
  assert(i < stack->size);

  stack->data[i].tag = RECORD_POLY;
  stack->data[i].arg.rec_id = id;
  stack->top = i+1;
}

static void push_assert_eq(op_stack_t *stack, int32_t x, int32_t y, int32_t offset) {
  uint32_t i;

  i = stack->top;
  if (i == stack->size) {
    extend_op_stack(stack);
  }
  assert(i < stack->size);

  stack->data[i].tag = ASSERT_EQ;
  stack->data[i].arg.eq.lhs = x;
  stack->data[i].arg.eq.rhs = y;
  stack->data[i].arg.eq.offset = offset;
  stack->top = i+1;
}

static void push_op(op_stack_t *stack, operation_t op) {
  uint32_t i;

  assert(op == PROPAGATE || op == PUSH);

  i = stack->top;
  if (i == stack->size) {
    extend_op_stack(stack);
  }
  assert(i < stack->size);

  stack->data[i].tag = op;
  stack->top = i+1;
}

static inline void push_propagate(op_stack_t *stack) {
  push_op(stack, PROPAGATE);
}

static inline void push_push(op_stack_t *stack) {
  push_op(stack, PUSH);
}



/*
 * Test bench:
 */
typedef struct test_bench_s {
  poly_table_t *ptable;
  substitution_t subst;
  subst_queue_t squeue;
  active_poly_table_t act;
  op_stack_t stack;
  equality_queue_t equeue;
  offset_manager_t manager; // under test

  poly_buffer_t buffer; // for normalization
} test_bench_t;

static void init_test_bench(test_bench_t *bench, poly_table_t *ptable) {
  uint32_t nv, np;

  np = ptable->npolys;
  nv = ptable->nvars;

  bench->ptable = ptable;
  init_substitution(&bench->subst, nv);
  init_subst_queue(&bench->squeue, nv);
  init_active_polys(&bench->act, np);
  init_op_stack(&bench->stack);
  init_equality_queue(&bench->equeue, nv);

  init_offset_manager(&bench->manager, &bench->equeue, notify_equality);

  init_poly_buffer(&bench->buffer);
}

static void delete_test_bench(test_bench_t *bench) {
  delete_substitution(&bench->subst);
  delete_subst_queue(&bench->squeue);
  delete_active_polys(&bench->act);
  delete_equality_queue(&bench->equeue);
  delete_op_stack(&bench->stack);
  delete_offset_manager(&bench->manager);
  delete_poly_buffer(&bench->buffer);
}


/*
 * Compute normal form of active poly k
 */
static void normalize(test_bench_t *bench, uint32_t k) {
  poly_buffer_t *buffer;
  int32_t idx;

  assert(0 <= k && k < bench->act.npolys);
  buffer = &bench->buffer;
  idx = bench->act.id[k];

  subst_poly_idx(&bench->subst, bench->ptable, buffer, idx);
  set_normal_form(bench->act.norm[k], buffer);
}

static void normalize_all(test_bench_t *bench) {
  uint32_t i, n;

  n = bench->act.npolys;
  for (i=0; i<n; i++) {
    normalize(bench, i);
  }
}


/*
 * TEST OPERATIONS
 */
static void test_activate(test_bench_t *bench, int32_t id) {
  polynomial_t *p;

  add_active_poly(&bench->act, bench->ptable, id);
  push_record_poly(&bench->stack, id);

  p = bench->ptable->poly[id];
  record_offset_poly(&bench->manager, id, id, p);
}
 
static void test_assert_eq(test_bench_t *bench, int32_t x, int32_t y, int32_t offset) {
  offset_equality_t e;
  rational_t q;

  push_assert_eq(&bench->stack, x, y, offset);

  e.lhs = x;
  e.rhs = y;
  e.offset = offset;
  subst_eq(&bench->subst, &e);

  if (e.lhs == e.rhs) {
    if (e.offset != 0) {
      // expected result = conflict
    }
  } else { 
    if (e.lhs < 0) {
      // convert 0 = y + offset into y := -offset
      e.lhs = e.rhs;
      e.rhs = -1;
      e.offset = -e.offset;
    }

    // add substitution e.lhs := e.rhs + e.offset
    add_subst(&bench->subst, e.lhs, e.rhs, e.offset);
    subst_queue_push_var(&bench->squeue, e.lhs);

    q_init(&q);
    q_set32(&q, offset);
    assert_offset_equality(&bench->manager, x, y, &q, e.lhs);
    q_clear(&q);
  }
}

static void test_propagate(test_bench_t *bench) {
  push_propagate(&bench->stack);
  offset_manager_propagate(&bench->manager);
}

static void test_push(test_bench_t *bench) {
  push_push(&bench->stack);
  push_mark(&bench->equeue);
  offset_manager_push(&bench->manager);
}



/*
 * PRINT FUNCTIONS
 */
static void print_mono(const char *prefix, rational_t *coeff, int32_t x, bool first) {
  bool negative;
  bool abs_one;

  negative = q_is_neg(coeff);
  if (negative) {
    if (first) {
      printf("- ");
    } else {
      printf(" - ");
    }
    abs_one = q_is_minus_one(coeff);
  } else {
    if (! first) {
      printf(" + ");
    }
    abs_one = q_is_one(coeff);
  }

  if (x == const_idx) {
    q_print_abs(stdout, coeff);
  } else {
    if (! abs_one) {
      q_print_abs(stdout, coeff);
      printf(" * ");
    }
    printf("%s%"PRId32, prefix, x);
  }
}

static void print_poly(polynomial_t *p) {
  uint32_t i, n;
  bool first;

  if (polynomial_is_zero(p)) {
    printf("0");
  } else {
    n = p->nterms;
    first = true;
    for (i=0; i<n; i++) {
      print_mono("x", &p->mono[i].coeff, p->mono[i].var, first);
      first = false;
    }
  }
}

static void print_buffer(poly_buffer_t *b) {
  monomial_t *mono;
  uint32_t i, n;
  bool first;

  n = poly_buffer_nterms(b);
  mono = poly_buffer_mono(b);
  if (n == 0) {
    printf("0");
  } else {
    first = true;
    for (i=0; i<n; i++) {
      print_mono("x", &mono[i].coeff, mono[i].var, first);
      first = false;
    }
  }  
}

static void print_normal_form(normal_form_t *f) {
  uint32_t i, n;
  bool first;
  
  n = f->nterms;
  if (n == 0) {
    printf("0");
  } else {
    first = true;
    for (i=0; i<n; i++) {
      print_mono("x", &f->mono[i].coeff, f->mono[i].var, first);
      first = false;
    }
  }
}

static void print_poly_table(poly_table_t *table) {
  polynomial_t *p;
  uint32_t i, n;

  n = table->npolys;
  for (i=0; i<n; i++) {
    p = table->poly[i];
    if (p != NULL) {
      printf("  x%"PRIu32" := ", i);
      print_poly(p);
      printf("\n");
    }
  }
}

static void print_active_polys(test_bench_t *bench) {
  polynomial_t *p;
  uint32_t i, n;
  int32_t idx;

  n = bench->act.npolys;
  for (i=0; i<n; i++) {
    idx = bench->act.id[i];
    printf("  act[%"PRIu32"]: x%"PRId32, i, idx);
    p = bench->ptable->poly[idx];
    if (p != NULL) {
      printf(" = ");
      print_poly(p);
    } 
    printf("\n");
    printf("         ---> ");
    print_normal_form(bench->act.norm[i]);
    printf("\n");
  }
}


/*
 * GLOBAL OBJECTS
 */
static poly_table_t poly_table;
static test_bench_t bench;

int main(void) {
  init_rationals();
  init_poly_table(&poly_table, 100, 20);
  build_poly_table(&poly_table, 10, 100);
  init_test_bench(&bench, &poly_table);

  printf("==== ALL POLYS ====\n");
  print_poly_table(&poly_table);
  printf("====\n");

  test_activate(&bench, 10);
  test_activate(&bench, 2);
  test_activate(&bench, 4);
  test_propagate(&bench);
  test_push(&bench);
  test_activate(&bench, 43);
  test_activate(&bench, 44);
  test_propagate(&bench);
  test_assert_eq(&bench, 4, 2, -12);
  test_assert_eq(&bench, 4, 10, 0);
  test_propagate(&bench);

  normalize_all(&bench);
  print_active_polys(&bench);

  delete_test_bench(&bench);
  delete_poly_table(&poly_table);
  cleanup_rationals();
  
  return 0;
}