/*
 * PRNG using a linear congruence + floating point implementation
 */

#ifndef __DPRNG_H

#define DPRNG_DEFAULT_SEED 91648253

// Returns a random double 0 <= x < 1. Seed must not be 0.
static inline double drand(double *seed) {
  double x;
  int q;

  x = (*seed) * 1389796;
  q = (int)(x / 2147483647);
  *seed -= (double)q * 2147483647;
  return x / 2147483647; 
}

// Returns a random integer 0 <= x < size. Seed must not be 0.
static inline uint32_t irand(double *seed, uint32_t size) {
  return (uint32_t)(drand(seed) * size); 
}

#endif