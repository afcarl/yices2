(set-logic QF_UFIDL)
(set-info :source |
Benchmark generated from the verification of programs manipulating linked lists inside UCLID. For more information see:
"Verifying properties of well-founded linked lists", Shuvendu Lahiri and Shaz
Qaader, POPL 2006

This benchmark was automatically translated into SMT-LIB format by Albert Oliveras.
|)
(set-info :smt-lib-version 2.0)
(set-info :category "industrial")
(set-info :status sat)
(declare-fun t.pc1 () Int)
(declare-fun t.PC_ONE () Int)
(declare-fun t.MAX () Int)
(declare-fun t.LEN_ZERO () Int)
(declare-fun en_RULES () Int)
(declare-fun t.ZERO () Int)
(declare-fun t.l_len () Int)
(declare-fun t.pc2 () Int)
(declare-fun t.rn () Int)
(declare-fun t.pc3 () Int)
(declare-fun t.req_len () Int)
(declare-fun t.rule () Int)
(declare-fun t.timer1_enabled () Bool)
(declare-fun t.timer1 () Bool)
(declare-fun t.flagack () Bool)
(declare-fun t.busy () Bool)
(declare-fun PRED_VAR__p0 () Bool)
(declare-fun PRED_VAR__p1 () Bool)
(declare-fun PRED_VAR__p01 () Bool)
(declare-fun PRED_VAR__p02 () Bool)
(declare-fun PRED_VAR__p03 () Bool)
(declare-fun PRED_VAR__p04 () Bool)
(declare-fun PRED_VAR__p05 () Bool)
(declare-fun PRED_VAR__p06 () Bool)
(declare-fun PRED_VAR__p07 () Bool)
(declare-fun PRED_VAR__p08 () Bool)
(declare-fun PRED_VAR__p09 () Bool)
(declare-fun PRED_VAR__p2 () Bool)
(declare-fun PRED_VAR__p10 () Bool)
(declare-fun PRED_VAR__p11 () Bool)
(declare-fun PRED_VAR__p12 () Bool)
(declare-fun PRED_VAR__p13 () Bool)
(declare-fun PRED_VAR__p14 () Bool)
(declare-fun PRED_VAR__p15 () Bool)
(declare-fun PRED_VAR__p16 () Bool)
(declare-fun PRED_VAR__p17 () Bool)
(declare-fun PRED_VAR__p18 () Bool)
(declare-fun PRED_VAR__p19 () Bool)
(declare-fun t.ctoggle () Bool)
(declare-fun t.cm_bit1 () Bool)
(declare-fun t.first () Bool)
(declare-fun t.ffirst () Bool)
(declare-fun t.flagm () Bool)
(declare-fun t.rtoggle () Bool)
(declare-fun t.flast () Bool)
(declare-fun t.timer3 () Bool)
(declare-fun t.timer2 () Bool)
(declare-fun t.timer3_enabled () Bool)
(assert (let ((?v_24 (+ 1 t.PC_ONE)) (?v_3 (not t.timer1_enabled)) (?v_5 (not t.timer3)) (?v_25 (not t.timer1)) (?v_0 (not t.flagack))) (let ((?v_7 (and (or ?v_25 t.flagack) (or ?v_0 t.timer1))) (?v_65 (+ 1 t.ZERO))) (let ((?v_10 (not (< ?v_65 t.rn))) (?v_11 (not (< t.MAX t.rn))) (?v_12 (= t.pc1 t.PC_ONE)) (?v_38 (= t.pc2 ?v_24))) (let ((?v_13 (not ?v_38)) (?v_14 (= t.pc3 t.PC_ONE)) (?v_15 (not (< t.ZERO t.rn))) (?v_16 (not t.flagm)) (?v_18 (= t.l_len t.LEN_ZERO)) (?v_19 (not (< t.rn t.ZERO))) (?v_63 (= t.MAX t.ZERO))) (let ((?v_21 (not ?v_63)) (?v_23 (+ 1 t.LEN_ZERO))) (let ((?v_28 (< ?v_23 t.l_len)) (?v_29 (= t.l_len ?v_23)) (?v_26 (< t.rn t.MAX))) (let ((?v_45 (and (and (and (and (and (= t.rule en_RULES) ?v_12) (or ?v_28 ?v_29)) ?v_16) ?v_26) t.busy)) (?v_27 (= t.pc1 ?v_24)) (?v_40 (= t.pc2 t.PC_ONE)) (?v_39 (or (not t.ctoggle) (and (or (not t.cm_bit1) t.rtoggle) (or (not t.rtoggle) t.cm_bit1)))) (?v_41 (not t.flast)) (?v_42 (not t.ffirst)) (?v_95 (not PRED_VAR__p1)) (?v_96 (not PRED_VAR__p01)) (?v_97 (not PRED_VAR__p02)) (?v_98 (not PRED_VAR__p03)) (?v_101 (not PRED_VAR__p04)) (?v_99 (not PRED_VAR__p05)) (?v_100 (not PRED_VAR__p06)) (?v_102 (not PRED_VAR__p08)) (?v_94 (not PRED_VAR__p09)) (?v_93 (not PRED_VAR__p10)) (?v_92 (not PRED_VAR__p11)) (?v_91 (not PRED_VAR__p12)) (?v_90 (not PRED_VAR__p13)) (?v_89 (not PRED_VAR__p15)) (?v_88 (not PRED_VAR__p16)) (?v_87 (not PRED_VAR__p17)) (?v_86 (not PRED_VAR__p18)) (?v_85 (not PRED_VAR__p19))) (let ((?v_103 (and PRED_VAR__p0 (and ?v_95 (and PRED_VAR__p2 (and ?v_96 (and ?v_97 (and ?v_98 (and ?v_99 (and ?v_100 PRED_VAR__p07))))))))) (?v_104 (and PRED_VAR__p0 (and ?v_95 (and PRED_VAR__p2 (and ?v_96 (and ?v_97 (and ?v_98 (and ?v_101 (and PRED_VAR__p05 ?v_100))))))))) (?v_31 (+ t.PC_ONE 2))) (let ((?v_32 (= t.pc1 ?v_31))) (let ((?v_2 (not ?v_32)) (?v_1 (+ t.PC_ONE 3)) (?v_33 (+ t.PC_ONE 4))) (let ((?v_34 (= t.pc1 ?v_33))) (let ((?v_4 (not ?v_34)) (?v_43 (= t.pc2 ?v_1))) (let ((?v_6 (not ?v_43)) (?v_35 (+ t.PC_ONE 5))) (let ((?v_36 (= t.pc1 ?v_35))) (let ((?v_8 (not ?v_36)) (?v_30 (= t.pc1 ?v_1))) (let ((?v_9 (not ?v_30)) (?v_54 (- t.ZERO 1))) (let ((?v_17 (not (= t.rn ?v_54)))) (let ((?v_20 (and ?v_12 (and ?v_13 (and ?v_14 (and ?v_15 (and ?v_16 (and ?v_17 (and (not ?v_18) (and ?v_19 t.busy))))))))) (?v_22 (and ?v_12 (and ?v_13 (and ?v_14 (and ?v_15 (and ?v_16 (and ?v_17 (and (not (< t.l_len t.LEN_ZERO)) (and ?v_18 ?v_19))))))))) (?v_46 (and (and (and (= t.rule (+ en_RULES 2)) ?v_27) t.flagack) ?v_28)) (?v_69 (and (and (and (= t.rule (+ en_RULES 3)) ?v_27) t.flagack) ?v_29)) (?v_47 (and (= t.rule (+ en_RULES 4)) ?v_30)) (?v_48 (and (and (= t.rule (+ en_RULES 6)) ?v_32) ?v_29)) (?v_49 (and (and (= t.rule (+ en_RULES 7)) ?v_32) ?v_28)) (?v_81 (and (= t.rule (+ en_RULES 8)) ?v_34)) (?v_60 (and (and (= t.rule (+ en_RULES 9)) ?v_36) ?v_5))) (let ((?v_67 (ite ?v_45 ?v_24 (ite (and (and (and (and (= t.rule (+ 1 en_RULES)) ?v_27) ?v_25) ?v_26) ?v_0) t.PC_ONE (ite ?v_46 t.PC_ONE (ite ?v_69 ?v_1 (ite ?v_47 t.PC_ONE (ite (and (and (and (and (= t.rule (+ en_RULES 5)) ?v_27) ?v_25) (= t.rn t.MAX)) ?v_0) ?v_31 (ite ?v_48 ?v_33 (ite ?v_49 ?v_33 (ite ?v_81 ?v_35 (ite ?v_60 t.PC_ONE t.pc1)))))))))))) (let ((?v_37 (= ?v_67 t.PC_ONE)) (?v_51 (and (and (and (= t.rule (+ en_RULES 10)) ?v_40) t.flagm) ?v_39)) (?v_70 (and (and (and (= t.rule (+ en_RULES 11)) ?v_38) t.flagm) (not ?v_39)))) (let ((?v_79 (ite ?v_51 ?v_24 (ite ?v_70 t.PC_ONE (ite (and (and (and (and (= t.rule (+ en_RULES 12)) ?v_40) t.timer3) t.first) (not t.timer2)) t.PC_ONE (ite (and (and (and (and (= t.rule (+ en_RULES 13)) ?v_40) t.timer3) t.first) t.timer2) ?v_31 (ite (and (and (and (and (= t.rule (+ en_RULES 14)) ?v_40) t.timer3) (not t.first)) t.timer2) ?v_31 (ite (and (= t.rule (+ en_RULES 15)) (= t.pc2 ?v_31)) t.PC_ONE (ite (and (and (and (= t.rule (+ en_RULES 16)) ?v_38) t.ffirst) ?v_41) ?v_1 (ite (and (and (and (= t.rule (+ en_RULES 17)) ?v_38) ?v_41) ?v_42) ?v_1 (ite (and (and (and (= t.rule (+ en_RULES 18)) ?v_38) t.flast) ?v_42) ?v_1 (ite (and (and (= t.rule (+ en_RULES 19)) ?v_43) ?v_0) t.PC_ONE t.pc2)))))))))))) (let ((?v_44 (= ?v_79 ?v_24)) (?v_53 (ite ?v_45 (+ 1 t.rn) (ite ?v_46 t.ZERO (ite ?v_47 t.ZERO (ite ?v_48 t.ZERO (ite ?v_49 t.ZERO t.rn))))))) (let ((?v_50 (< t.ZERO ?v_53)) (?v_74 (not (and (and (= t.rule (+ en_RULES 20)) ?v_14) t.flagm)))) (let ((?v_52 (or ?v_45 (and (not ?v_51) (and ?v_74 t.flagm)))) (?v_55 (= ?v_53 ?v_54)) (?v_61 (and (and (= t.rule (+ en_RULES 24)) ?v_14) (not t.busy)))) (let ((?v_57 (ite ?v_46 (- t.l_len 1) (ite ?v_61 t.req_len t.l_len)))) (let ((?v_56 (< ?v_57 t.LEN_ZERO)) (?v_58 (= ?v_57 t.LEN_ZERO)) (?v_59 (< ?v_53 t.ZERO)) (?v_62 (and (not ?v_47) (and (not ?v_60) (or ?v_61 t.busy)))) (?v_64 (< t.MAX ?v_53)) (?v_66 (< ?v_65 ?v_53)) (?v_68 (= ?v_67 ?v_1)) (?v_73 (not ?v_69)) (?v_75 (not (and (and (= t.rule (+ en_RULES 21)) ?v_14) t.flagack)))) (let ((?v_71 (and ?v_73 (or ?v_70 (and ?v_75 t.flagack))))) (let ((?v_76 (not ?v_71)) (?v_72 (= ?v_67 ?v_35)) (?v_77 (or ?v_45 (and (not ?v_46) (and ?v_73 (and ?v_74 (and ?v_75 (and (not (and (and (and (= t.rule (+ en_RULES 22)) ?v_14) t.timer1_enabled) t.timer1)) t.timer1)))))))) (let ((?v_78 (and (or (not ?v_77) ?v_71) (or ?v_76 ?v_77))) (?v_80 (= ?v_79 ?v_1)) (?v_82 (or ?v_81 (and (not (and (and (and (= t.rule (+ en_RULES 23)) ?v_14) t.timer3_enabled) t.timer3)) t.timer3))) (?v_83 (= ?v_67 ?v_33)) (?v_84 (= ?v_67 ?v_31))) (and (and (or (or (or (and ?v_2 (and ?v_3 (and ?v_4 (and ?v_5 (and ?v_6 (and ?v_7 (and ?v_8 (and ?v_0 (and ?v_9 (and ?v_10 (and ?v_11 ?v_20))))))))))) (and ?v_2 (and ?v_3 (and ?v_4 (and ?v_5 (and ?v_6 (and ?v_7 (and ?v_8 (and ?v_0 (and ?v_9 (and ?v_10 (and ?v_11 ?v_22)))))))))))) (and ?v_21 (and ?v_2 (and ?v_3 (and ?v_4 (and ?v_5 (and ?v_6 (and ?v_7 (and ?v_8 (and ?v_0 (and ?v_9 (and ?v_10 ?v_20)))))))))))) (and ?v_21 (and ?v_2 (and ?v_3 (and ?v_4 (and ?v_5 (and ?v_6 (and ?v_7 (and ?v_8 (and ?v_0 (and ?v_9 (and ?v_10 ?v_22)))))))))))) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (or (and PRED_VAR__p0 ?v_37) (and (not PRED_VAR__p0) (not ?v_37))) (or (and PRED_VAR__p1 ?v_44) (and ?v_95 (not ?v_44)))) PRED_VAR__p2) (or (and PRED_VAR__p01 ?v_50) (and ?v_96 (not ?v_50)))) (or (and PRED_VAR__p02 ?v_52) (and ?v_97 (not ?v_52)))) (or (and PRED_VAR__p03 ?v_55) (and ?v_98 (not ?v_55)))) (or (and PRED_VAR__p04 ?v_56) (and ?v_101 (not ?v_56)))) (or (and PRED_VAR__p05 ?v_58) (and ?v_99 (not ?v_58)))) (or (and PRED_VAR__p06 ?v_59) (and ?v_100 (not ?v_59)))) (or (and PRED_VAR__p07 ?v_62) (and (not PRED_VAR__p07) (not ?v_62)))) (or (and PRED_VAR__p08 ?v_63) (and ?v_102 ?v_21))) (or (and PRED_VAR__p09 ?v_64) (and ?v_94 (not ?v_64)))) (or (and PRED_VAR__p10 ?v_66) (and ?v_93 (not ?v_66)))) (or (and PRED_VAR__p11 ?v_68) (and ?v_92 (not ?v_68)))) (or (and PRED_VAR__p12 ?v_71) (and ?v_91 ?v_76))) (or (and PRED_VAR__p13 ?v_72) (and ?v_90 (not ?v_72)))) (or (and PRED_VAR__p14 ?v_78) (and (not PRED_VAR__p14) (not ?v_78)))) (or (and PRED_VAR__p15 ?v_80) (and ?v_89 (not ?v_80)))) (or (and PRED_VAR__p16 ?v_82) (and ?v_88 (not ?v_82)))) (or (and PRED_VAR__p17 ?v_83) (and ?v_87 (not ?v_83)))) ?v_86) (or (and PRED_VAR__p19 ?v_84) (and ?v_85 (not ?v_84))))) (not (or (or (or (and ?v_85 (and ?v_86 (and ?v_87 (and ?v_88 (and ?v_89 (and PRED_VAR__p14 (and ?v_90 (and ?v_91 (and ?v_92 (and ?v_93 (and ?v_94 ?v_103))))))))))) (and ?v_85 (and ?v_86 (and ?v_87 (and ?v_88 (and ?v_89 (and PRED_VAR__p14 (and ?v_90 (and ?v_91 (and ?v_92 (and ?v_93 (and ?v_94 ?v_104)))))))))))) (and ?v_102 (and ?v_85 (and ?v_86 (and ?v_87 (and ?v_88 (and ?v_89 (and PRED_VAR__p14 (and ?v_90 (and ?v_91 (and ?v_92 (and ?v_93 ?v_103)))))))))))) (and ?v_102 (and ?v_85 (and ?v_86 (and ?v_87 (and ?v_88 (and ?v_89 (and PRED_VAR__p14 (and ?v_90 (and ?v_91 (and ?v_92 (and ?v_93 ?v_104))))))))))))))))))))))))))))))))))))))))))))
(check-sat)
(exit)