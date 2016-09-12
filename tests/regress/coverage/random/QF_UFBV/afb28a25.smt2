(set-info :source |fuzzsmt|)
(set-info :smt-lib-version 2.0)
(set-info :category "random")
(set-info :status unknown)
(set-logic QF_UFBV)
(declare-fun f0 ( (_ BitVec 8) (_ BitVec 12)) (_ BitVec 14))
(declare-fun f1 ( (_ BitVec 9) (_ BitVec 7)) (_ BitVec 14))
(declare-fun p0 ( (_ BitVec 13) (_ BitVec 13)) Bool)
(declare-fun p1 ( (_ BitVec 12) (_ BitVec 10) (_ BitVec 13)) Bool)
(declare-fun v0 () (_ BitVec 3))
(declare-fun v1 () (_ BitVec 11))
(declare-fun v2 () (_ BitVec 16))
(assert (let ((e3(_ bv61612 16)))
(let ((e4 (! (f1 ((_ zero_extend 6) v0) ((_ extract 8 2) v2)) :named term4)))
(let ((e5 (! (ite (p0 ((_ extract 12 0) e4) ((_ sign_extend 2) v1)) (_ bv1 1) (_ bv0 1)) :named term5)))
(let ((e6 (! (f1 ((_ extract 10 2) v1) ((_ sign_extend 6) e5)) :named term6)))
(let ((e7 (! (f1 ((_ zero_extend 6) v0) ((_ zero_extend 4) v0)) :named term7)))
(let ((e8 (! (f0 ((_ zero_extend 7) e5) ((_ extract 11 0) e6)) :named term8)))
(let ((e9 (! (ite (p0 ((_ extract 13 1) e8) ((_ zero_extend 12) e5)) (_ bv1 1) (_ bv0 1)) :named term9)))
(let ((e10 (! (ite (p0 ((_ extract 12 0) e7) ((_ zero_extend 10) v0)) (_ bv1 1) (_ bv0 1)) :named term10)))
(let ((e11 (! (ite (p0 ((_ extract 12 0) e4) ((_ extract 12 0) e7)) (_ bv1 1) (_ bv0 1)) :named term11)))
(let ((e12 (! ((_ repeat 1) v2) :named term12)))
(let ((e13 (! (ite (p1 ((_ zero_extend 1) v1) ((_ extract 9 0) e4) ((_ zero_extend 2) v1)) (_ bv1 1) (_ bv0 1)) :named term13)))
(let ((e14 (! (ite (distinct v1 ((_ zero_extend 10) e5)) (_ bv1 1) (_ bv0 1)) :named term14)))
(let ((e15 (! (ite (bvult e12 e12) (_ bv1 1) (_ bv0 1)) :named term15)))
(let ((e16 (! (bvxor ((_ zero_extend 10) e14) v1) :named term16)))
(let ((e17 (! (bvnor e10 e9) :named term17)))
(let ((e18 (! (bvcomp ((_ sign_extend 15) e15) v2) :named term18)))
(let ((e19 (! (bvurem ((_ sign_extend 15) e13) e3) :named term19)))
(let ((e20 (! (p0 ((_ sign_extend 10) v0) ((_ extract 13 1) e4)) :named term20)))
(let ((e21 (! (bvslt e13 e17) :named term21)))
(let ((e22 (! (p1 ((_ zero_extend 11) e9) ((_ zero_extend 9) e11) ((_ extract 12 0) e19)) :named term22)))
(let ((e23 (! (bvsle ((_ sign_extend 10) e17) v1) :named term23)))
(let ((e24 (! (bvslt e7 ((_ sign_extend 13) e9)) :named term24)))
(let ((e25 (! (= e7 e4) :named term25)))
(let ((e26 (! (bvsge v2 ((_ sign_extend 2) e6)) :named term26)))
(let ((e27 (! (distinct ((_ zero_extend 5) v1) v2) :named term27)))
(let ((e28 (! (bvsgt e12 ((_ sign_extend 2) e8)) :named term28)))
(let ((e29 (! (bvuge e4 ((_ zero_extend 13) e11)) :named term29)))
(let ((e30 (! (bvsgt v1 ((_ zero_extend 10) e11)) :named term30)))
(let ((e31 (! (bvuge ((_ zero_extend 13) e10) e7) :named term31)))
(let ((e32 (! (distinct e19 e3) :named term32)))
(let ((e33 (! (p1 ((_ sign_extend 11) e13) ((_ extract 13 4) e7) ((_ extract 12 0) e7)) :named term33)))
(let ((e34 (! (distinct ((_ sign_extend 8) v0) e16) :named term34)))
(let ((e35 (! (= e8 ((_ sign_extend 13) e10)) :named term35)))
(let ((e36 (! (bvsle e3 ((_ sign_extend 2) e7)) :named term36)))
(let ((e37 (! (= ((_ zero_extend 15) e11) e19) :named term37)))
(let ((e38 (! (bvugt ((_ sign_extend 15) e15) e12) :named term38)))
(let ((e39 (! (bvsgt v0 ((_ sign_extend 2) e5)) :named term39)))
(let ((e40 (! (bvult e19 e3) :named term40)))
(let ((e41 (! (bvult ((_ sign_extend 13) e17) e8) :named term41)))
(let ((e42 (! (bvuge ((_ sign_extend 11) v0) e7) :named term42)))
(let ((e43 (! (bvult e8 ((_ sign_extend 3) e16)) :named term43)))
(let ((e44 (! (bvuge e6 ((_ sign_extend 13) e13)) :named term44)))
(let ((e45 (! (bvult ((_ sign_extend 13) e13) e4) :named term45)))
(let ((e46 (! (bvsgt e7 e6) :named term46)))
(let ((e47 (! (p1 ((_ sign_extend 11) e13) ((_ extract 12 3) v2) ((_ sign_extend 10) v0)) :named term47)))
(let ((e48 (! (bvsge ((_ sign_extend 15) e18) e19) :named term48)))
(let ((e49 (! (bvule e19 ((_ sign_extend 5) v1)) :named term49)))
(let ((e50 (! (bvugt e12 ((_ sign_extend 15) e15)) :named term50)))
(let ((e51 (! (bvslt ((_ zero_extend 13) v0) e19) :named term51)))
(let ((e52 (! (bvult e19 ((_ zero_extend 2) e8)) :named term52)))
(let ((e53 (! (bvuge e9 e10) :named term53)))
(let ((e54 (! (bvsgt e3 ((_ sign_extend 2) e7)) :named term54)))
(let ((e55 (! (= ((_ sign_extend 13) e13) e8) :named term55)))
(let ((e56 (! (bvugt ((_ sign_extend 15) e5) e19) :named term56)))
(let ((e57 (! (bvuge e19 e12) :named term57)))
(let ((e58 (! (p1 ((_ zero_extend 1) e16) ((_ extract 9 0) e3) ((_ zero_extend 2) v1)) :named term58)))
(let ((e59 (! (bvuge e19 ((_ sign_extend 15) e11)) :named term59)))
(let ((e60 (! (bvule v2 ((_ zero_extend 5) v1)) :named term60)))
(let ((e61 (! (bvsle e7 ((_ sign_extend 13) e5)) :named term61)))
(let ((e62 (! (bvult e5 e9) :named term62)))
(let ((e63 (! (p1 ((_ sign_extend 11) e10) ((_ sign_extend 9) e17) ((_ sign_extend 12) e17)) :named term63)))
(let ((e64 (! (p1 ((_ sign_extend 11) e5) ((_ zero_extend 9) e10) ((_ zero_extend 12) e5)) :named term64)))
(let ((e65 (! (bvugt v0 ((_ sign_extend 2) e18)) :named term65)))
(let ((e66 (! (bvsge ((_ sign_extend 2) e11) v0) :named term66)))
(let ((e67 (! (bvult v2 ((_ zero_extend 15) e17)) :named term67)))
(let ((e68 (! (= e8 ((_ zero_extend 13) e15)) :named term68)))
(let ((e69 (! (bvult v2 ((_ sign_extend 15) e5)) :named term69)))
(let ((e70 (! (bvuge ((_ zero_extend 2) e6) v2) :named term70)))
(let ((e71 (! (= ((_ sign_extend 15) e5) v2) :named term71)))
(let ((e72 (! (bvsgt ((_ zero_extend 10) e13) v1) :named term72)))
(let ((e73 (! (bvugt e12 ((_ sign_extend 15) e18)) :named term73)))
(let ((e74 (! (bvule e11 e17) :named term74)))
(let ((e75 (! (bvsle e13 e15) :named term75)))
(let ((e76 (! (bvsge v1 e16) :named term76)))
(let ((e77 (! (bvule e6 e7) :named term77)))
(let ((e78 (! (p1 ((_ extract 12 1) e6) ((_ extract 11 2) v2) ((_ extract 14 2) e19)) :named term78)))
(let ((e79 (! (distinct e19 ((_ sign_extend 15) e14)) :named term79)))
(let ((e80 (! (=> e39 e67) :named term80)))
(let ((e81 (! (or e21 e46) :named term81)))
(let ((e82 (! (not e61) :named term82)))
(let ((e83 (! (xor e49 e31) :named term83)))
(let ((e84 (! (= e75 e76) :named term84)))
(let ((e85 (! (xor e83 e42) :named term85)))
(let ((e86 (! (= e84 e79) :named term86)))
(let ((e87 (! (and e33 e81) :named term87)))
(let ((e88 (! (and e69 e36) :named term88)))
(let ((e89 (! (ite e50 e52 e35) :named term89)))
(let ((e90 (! (= e30 e32) :named term90)))
(let ((e91 (! (xor e66 e53) :named term91)))
(let ((e92 (! (ite e26 e60 e23) :named term92)))
(let ((e93 (! (ite e72 e44 e25) :named term93)))
(let ((e94 (! (or e74 e80) :named term94)))
(let ((e95 (! (= e47 e20) :named term95)))
(let ((e96 (! (or e27 e78) :named term96)))
(let ((e97 (! (ite e55 e85 e51) :named term97)))
(let ((e98 (! (and e43 e86) :named term98)))
(let ((e99 (! (and e29 e89) :named term99)))
(let ((e100 (! (not e70) :named term100)))
(let ((e101 (! (= e34 e71) :named term101)))
(let ((e102 (! (= e82 e93) :named term102)))
(let ((e103 (! (not e94) :named term103)))
(let ((e104 (! (or e57 e54) :named term104)))
(let ((e105 (! (xor e58 e37) :named term105)))
(let ((e106 (! (or e24 e96) :named term106)))
(let ((e107 (! (=> e40 e97) :named term107)))
(let ((e108 (! (= e45 e99) :named term108)))
(let ((e109 (! (not e56) :named term109)))
(let ((e110 (! (not e22) :named term110)))
(let ((e111 (! (xor e100 e38) :named term111)))
(let ((e112 (! (=> e62 e95) :named term112)))
(let ((e113 (! (=> e91 e77) :named term113)))
(let ((e114 (! (or e59 e48) :named term114)))
(let ((e115 (! (= e73 e92) :named term115)))
(let ((e116 (! (=> e110 e104) :named term116)))
(let ((e117 (! (not e107) :named term117)))
(let ((e118 (! (ite e90 e102 e65) :named term118)))
(let ((e119 (! (not e28) :named term119)))
(let ((e120 (! (and e109 e106) :named term120)))
(let ((e121 (! (and e64 e68) :named term121)))
(let ((e122 (! (ite e98 e114 e98) :named term122)))
(let ((e123 (! (= e119 e103) :named term123)))
(let ((e124 (! (ite e115 e108 e120) :named term124)))
(let ((e125 (! (or e112 e111) :named term125)))
(let ((e126 (! (xor e88 e113) :named term126)))
(let ((e127 (! (and e41 e87) :named term127)))
(let ((e128 (! (not e125) :named term128)))
(let ((e129 (! (xor e118 e123) :named term129)))
(let ((e130 (! (and e63 e116) :named term130)))
(let ((e131 (! (not e126) :named term131)))
(let ((e132 (! (xor e101 e101) :named term132)))
(let ((e133 (! (or e122 e131) :named term133)))
(let ((e134 (! (xor e129 e105) :named term134)))
(let ((e135 (! (xor e127 e121) :named term135)))
(let ((e136 (! (xor e135 e128) :named term136)))
(let ((e137 (! (not e124) :named term137)))
(let ((e138 (! (not e130) :named term138)))
(let ((e139 (! (or e133 e137) :named term139)))
(let ((e140 (! (ite e138 e136 e136) :named term140)))
(let ((e141 (! (=> e117 e140) :named term141)))
(let ((e142 (! (or e134 e141) :named term142)))
(let ((e143 (! (ite e142 e132 e139) :named term143)))
(let ((e144 (! (and e143 (not (= e3 (_ bv0 16)))) :named term144)))
e144
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(check-sat)
(set-option :regular-output-channel "/dev/null")
(get-model)
(get-value (term4))
(get-value (term5))
(get-value (term6))
(get-value (term7))
(get-value (term8))
(get-value (term9))
(get-value (term10))
(get-value (term11))
(get-value (term12))
(get-value (term13))
(get-value (term14))
(get-value (term15))
(get-value (term16))
(get-value (term17))
(get-value (term18))
(get-value (term19))
(get-value (term20))
(get-value (term21))
(get-value (term22))
(get-value (term23))
(get-value (term24))
(get-value (term25))
(get-value (term26))
(get-value (term27))
(get-value (term28))
(get-value (term29))
(get-value (term30))
(get-value (term31))
(get-value (term32))
(get-value (term33))
(get-value (term34))
(get-value (term35))
(get-value (term36))
(get-value (term37))
(get-value (term38))
(get-value (term39))
(get-value (term40))
(get-value (term41))
(get-value (term42))
(get-value (term43))
(get-value (term44))
(get-value (term45))
(get-value (term46))
(get-value (term47))
(get-value (term48))
(get-value (term49))
(get-value (term50))
(get-value (term51))
(get-value (term52))
(get-value (term53))
(get-value (term54))
(get-value (term55))
(get-value (term56))
(get-value (term57))
(get-value (term58))
(get-value (term59))
(get-value (term60))
(get-value (term61))
(get-value (term62))
(get-value (term63))
(get-value (term64))
(get-value (term65))
(get-value (term66))
(get-value (term67))
(get-value (term68))
(get-value (term69))
(get-value (term70))
(get-value (term71))
(get-value (term72))
(get-value (term73))
(get-value (term74))
(get-value (term75))
(get-value (term76))
(get-value (term77))
(get-value (term78))
(get-value (term79))
(get-value (term80))
(get-value (term81))
(get-value (term82))
(get-value (term83))
(get-value (term84))
(get-value (term85))
(get-value (term86))
(get-value (term87))
(get-value (term88))
(get-value (term89))
(get-value (term90))
(get-value (term91))
(get-value (term92))
(get-value (term93))
(get-value (term94))
(get-value (term95))
(get-value (term96))
(get-value (term97))
(get-value (term98))
(get-value (term99))
(get-value (term100))
(get-value (term101))
(get-value (term102))
(get-value (term103))
(get-value (term104))
(get-value (term105))
(get-value (term106))
(get-value (term107))
(get-value (term108))
(get-value (term109))
(get-value (term110))
(get-value (term111))
(get-value (term112))
(get-value (term113))
(get-value (term114))
(get-value (term115))
(get-value (term116))
(get-value (term117))
(get-value (term118))
(get-value (term119))
(get-value (term120))
(get-value (term121))
(get-value (term122))
(get-value (term123))
(get-value (term124))
(get-value (term125))
(get-value (term126))
(get-value (term127))
(get-value (term128))
(get-value (term129))
(get-value (term130))
(get-value (term131))
(get-value (term132))
(get-value (term133))
(get-value (term134))
(get-value (term135))
(get-value (term136))
(get-value (term137))
(get-value (term138))
(get-value (term139))
(get-value (term140))
(get-value (term141))
(get-value (term142))
(get-value (term143))
(get-value (term144))
(get-info :all-statistics)