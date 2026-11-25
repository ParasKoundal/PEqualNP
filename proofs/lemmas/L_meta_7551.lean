import Mathlib
import PEqualNP.Defs

open PEqualNP.CircuitLowerBounds PEqualNP.MetaComplexity

namespace PEqualNP.Outside.L_meta_7551

private def stepFn (w : List Bool) (t : Fin 32768) : List Bool :=
  let a := w.getD (t.val % 128) false
  let b := w.getD (t.val / 128 % 128) false
  w ++ [if t.val < 16384 then a && b else a || b]

private def gateEvalFn (w : List Bool) (g : Gate) : List Bool :=
  w ++ [g.op.eval (g.inputs.map fun i => w.getD i false)]

private def mkInstr (op : Bool) (a b : ℕ) : Fin 32768 :=
  ⟨(if op then 16384 else 0) + 128 * (b % 128) + (a % 128), by cases op <;> simp <;> omega⟩

private def compileGate (g : Gate) : Fin 32768 :=
  match g.op with
  | GateOp.and =>
    match g.inputs with
    | [] => mkInstr false 1 1
    | [u] => mkInstr false (u + 2) 1
    | u :: v :: _ => mkInstr false (u + 2) (v + 2)
  | _ =>
    match g.inputs with
    | [] => mkInstr true 0 0
    | [u] => mkInstr true (u + 2) 0
    | u :: v :: _ => mkInstr true (u + 2) (v + 2)

private lemma getD_cons_two (w : List Bool) (u : ℕ) :
    (false :: true :: w).getD (u + 2) false = w.getD u false := by
  simp [List.getD]

private lemma getD_append_left (w1 w2 : List Bool) (i : ℕ) (h : i < w1.length) :
    (w1 ++ w2).getD i false = w1.getD i false := by
  simp [List.getD, List.getElem?_append_left h]

private lemma getD_append_last (w : List Bool) (b : Bool) :
    (w ++ [b]).getD w.length false = b := by
  simp [List.getD]

private lemma getD_ge_length (w : List Bool) (i : ℕ) (h : w.length ≤ i) :
    w.getD i false = false := by
  simp [List.getD, List.getElem?_eq_none h]

private lemma stepFn_mkInstr_false (w : List Bool) (a b : ℕ) (ha : a < 128) (hb : b < 128) :
    stepFn w (mkInstr false a b) = w ++ [w.getD a false && w.getD b false] := by
  unfold stepFn mkInstr
  have h1 : (0 + 128 * (b % 128) + a % 128) % 128 = a := by omega
  have h2 : (0 + 128 * (b % 128) + a % 128) / 128 % 128 = b := by omega
  have h3 : 0 + 128 * (b % 128) + a % 128 < 16384 := by omega
  change w ++ [if 0 + 128 * (b % 128) + a % 128 < 16384 then
      w.getD ((0 + 128 * (b % 128) + a % 128) % 128) false && w.getD ((0 + 128 * (b % 128) + a % 128) / 128 % 128) false
    else
      w.getD ((0 + 128 * (b % 128) + a % 128) % 128) false || w.getD ((0 + 128 * (b % 128) + a % 128) / 128 % 128) false] =
    w ++ [w.getD a false && w.getD b false]
  rw [h1, h2, if_pos h3]

private lemma stepFn_mkInstr_true (w : List Bool) (a b : ℕ) (ha : a < 128) (hb : b < 128) :
    stepFn w (mkInstr true a b) = w ++ [w.getD a false || w.getD b false] := by
  unfold stepFn mkInstr
  have h1 : (16384 + 128 * (b % 128) + a % 128) % 128 = a := by omega
  have h2 : (16384 + 128 * (b % 128) + a % 128) / 128 % 128 = b := by omega
  have h3 : ¬(16384 + 128 * (b % 128) + a % 128 < 16384) := by omega
  change w ++ [if 16384 + 128 * (b % 128) + a % 128 < 16384 then
      w.getD ((16384 + 128 * (b % 128) + a % 128) % 128) false && w.getD ((16384 + 128 * (b % 128) + a % 128) / 128 % 128) false
    else
      w.getD ((16384 + 128 * (b % 128) + a % 128) % 128) false || w.getD ((16384 + 128 * (b % 128) + a % 128) / 128 % 128) false] =
    w ++ [w.getD a false || w.getD b false]
  rw [h1, h2, if_neg h3]

private lemma stepFn_compileGate (w : List Bool) (g : Gate)
    (hmono : g.op ∈ ({GateOp.and, GateOp.or} : Set GateOp) ∧ g.inputs.length ≤ 2)
    (hbnd : ∀ u ∈ g.inputs, u < 126) :
    stepFn (false :: true :: w) (compileGate g) =
      false :: true :: gateEvalFn w g := by
  rcases hmono with ⟨hop, hlen⟩
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hop
  rcases hop with hop | hop
  · rcases hinputs : g.inputs with _ | ⟨u, _ | ⟨v, _ | _⟩⟩
    · simp [compileGate, hop, hinputs, stepFn_mkInstr_false, gateEvalFn, GateOp.eval, List.getD]
    · have hu : u < 126 := hbnd u (by simp [hinputs])
      rw [compileGate, hop, hinputs, stepFn_mkInstr_false _ (u + 2) 1 (by omega) (by omega)]
      simp [gateEvalFn, GateOp.eval, hop, hinputs, List.getD]
    · have hu : u < 126 := hbnd u (by simp [hinputs])
      have hv : v < 126 := hbnd v (by simp [hinputs])
      rw [compileGate, hop, hinputs, stepFn_mkInstr_false _ (u + 2) (v + 2) (by omega) (by omega)]
      simp [gateEvalFn, GateOp.eval, hop, hinputs]
    · exfalso; simp [hinputs] at hlen
  · rcases hinputs : g.inputs with _ | ⟨u, _ | ⟨v, _ | _⟩⟩
    · simp [compileGate, hop, hinputs, stepFn_mkInstr_true, gateEvalFn, GateOp.eval, List.getD]
    · have hu : u < 126 := hbnd u (by simp [hinputs])
      rw [compileGate, hop, hinputs, stepFn_mkInstr_true _ (u + 2) 0 (by omega) (by omega)]
      simp [gateEvalFn, GateOp.eval, hop, hinputs, List.getD]
    · have hu : u < 126 := hbnd u (by simp [hinputs])
      have hv : v < 126 := hbnd v (by simp [hinputs])
      rw [compileGate, hop, hinputs, stepFn_mkInstr_true _ (u + 2) (v + 2) (by omega) (by omega)]
      simp [gateEvalFn, GateOp.eval, hop, hinputs]
    · exfalso; simp [hinputs] at hlen

private lemma foldl_stepFn_length (w : List Bool) (p : List (Fin 32768)) :
    (p.foldl stepFn w).length = w.length + p.length := by
  induction p generalizing w with
  | nil => simp
  | cons t ts ih =>
    simp [stepFn, ih]
    omega

private lemma foldl_stepFn_getD_lt (w : List Bool) (p : List (Fin 32768)) (i : ℕ)
    (hi : i < w.length) :
    (p.foldl stepFn w).getD i false = w.getD i false := by
  induction p generalizing w with
  | nil => rfl
  | cons t ts ih =>
    simp only [List.foldl_cons]
    have hi' : i < (stepFn w t).length := by
      simp [stepFn]; omega
    rw [ih (stepFn w t) hi']
    unfold stepFn
    exact getD_append_left w _ i hi

private lemma foldl_gateEvalFn_length (w : List Bool) (gs : List Gate) :
    (gs.foldl gateEvalFn w).length = w.length + gs.length := by
  induction gs generalizing w with
  | nil => simp
  | cons g gs ih =>
    simp [gateEvalFn, ih]
    omega

private lemma foldl_gateEvalFn_getD_lt (w : List Bool) (gs : List Gate) (i : ℕ)
    (hi : i < w.length) :
    (gs.foldl gateEvalFn w).getD i false = w.getD i false := by
  induction gs generalizing w with
  | nil => rfl
  | cons g gs ih =>
    simp only [List.foldl_cons]
    have hi' : i < (gateEvalFn w g).length := by
      simp [gateEvalFn]; omega
    rw [ih (gateEvalFn w g) hi']
    unfold gateEvalFn
    exact getD_append_left w _ i hi

private lemma foldl_compileGate (w : List Bool) (gs : List Gate)
    (hmono : ∀ g ∈ gs, g.op ∈ ({GateOp.and, GateOp.or} : Set GateOp) ∧ g.inputs.length ≤ 2)
    (hbnd : ∀ g ∈ gs, ∀ u ∈ g.inputs, u < 126) :
    (gs.map compileGate).foldl stepFn (false :: true :: w) =
      false :: true :: gs.foldl gateEvalFn w := by
  induction gs generalizing w with
  | nil => rfl
  | cons g gs ih =>
    simp only [List.map_cons, List.foldl_cons]
    rw [stepFn_compileGate w g (hmono g (by simp)) (hbnd g (by simp))]
    exact ih (gateEvalFn w g)
      (fun g' hg' => hmono g' (List.mem_cons_of_mem g hg'))
      (fun g' hg' => hbnd g' (List.mem_cons_of_mem g hg'))

end PEqualNP.Outside.L_meta_7551

open PEqualNP.Outside.L_meta_7551

theorem PEqualNP.Outside.L_meta_7551 : have x1 : List Bool → Fin (32768 : ℕ) → List Bool := fun (x1 : List Bool) (x2 : Fin (32768 : ℕ)) =>   have x3 : Bool := x1.getD (↑x2 % (128 : ℕ)) Bool.false;   have x4 : Bool := x1.getD (↑x2 / (128 : ℕ) % (128 : ℕ)) Bool.false;   x1 ++ [if ↑x2 < (16384 : ℕ) then x3 && x4 else x3 || x4]; ∀ (x2 : PEqualNP.CircuitLowerBounds.Circuit), PEqualNP.MetaComplexity.Monotone2 x2 → x2.size ≤ (62 : ℕ) → (∀ (x5 : Fin x2.gates.length), ∀ x6 ∈ (x2.gates.get x5).inputs, x6 < (27 : ℕ) + ↑x5) → ∃ (x6 : List (Fin (32768 : ℕ))), x6.length = (62 : ℕ) ∧ ∀ (x7 : List Bool), x7.length = (27 : ℕ) → (List.foldl x1 (Bool.false :: Bool.true :: x7) x6).getD (90 : ℕ) Bool.false = x2.eval x7 := by
  intro x1 C hmono hsize hord
  change ∀ (x7 : List Bool), _ at *
  have hstep : x1 = stepFn := rfl
  rw [hstep]
  have hwires : ∀ x : List Bool, C.wires x = C.gates.foldl gateEvalFn x := fun _ => rfl
  have hbnd_all : ∀ g ∈ C.gates, ∀ u ∈ g.inputs, u < 126 := by
    intro g hg u hu
    obtain ⟨i, rfl⟩ := List.mem_iff_get.mp hg
    have h1 := hord i u hu
    have h2 : i.val < C.gates.length := i.isLt
    have h3 : C.gates.length ≤ 62 := hsize
    omega
  by_cases hfull : C.gates.length = 62 ∧ C.output = 88
  · rcases hfull with ⟨hlen62, hout88⟩
    refine ⟨C.gates.map compileGate, by simp [hlen62], ?_⟩
    intro x hx
    rw [foldl_compileGate x C.gates hmono hbnd_all]
    rw [show (90 : ℕ) = 88 + 2 from rfl, getD_cons_two]
    rw [Circuit.eval, hwires, hout88]
  · let k := min C.gates.length 61
    have hk61 : k ≤ 61 := Nat.min_le_right _ _
    have hklen : k ≤ C.gates.length := Nat.min_le_left _ _
    let outInstr : Fin 32768 :=
      if C.output < 27 + k then mkInstr false (C.output + 2) 1 else mkInstr true 0 0
    let p : List (Fin 32768) :=
      (C.gates.take k).map compileGate ++ List.replicate (61 - k) (mkInstr true 0 0) ++ [outInstr]
    refine ⟨p, ?_, ?_⟩
    · simp only [p, List.length_append, List.length_map, List.length_take,
        List.length_replicate, List.length_singleton]
      omega
    · intro x hx
      simp only [p, List.foldl_append, List.foldl_cons, List.foldl_nil]
      have hmono_take : ∀ g ∈ C.gates.take k,
          g.op ∈ ({GateOp.and, GateOp.or} : Set GateOp) ∧ g.inputs.length ≤ 2 :=
        fun g hg => hmono g (List.mem_of_mem_take hg)
      have hbnd_take : ∀ g ∈ C.gates.take k, ∀ u ∈ g.inputs, u < 126 :=
        fun g hg => hbnd_all g (List.mem_of_mem_take hg)
      rw [foldl_compileGate x (C.gates.take k) hmono_take hbnd_take]
      set wk := (C.gates.take k).foldl gateEvalFn x
      have hwk_len : wk.length = 27 + k := by
        simp only [wk, foldl_gateEvalFn_length, hx, List.length_take]
        omega
      set wpad := (List.replicate (61 - k) (mkInstr true 0 0)).foldl stepFn (false :: true :: wk)
      have hwpad_len : wpad.length = 90 := by
        simp only [wpad, foldl_stepFn_length, List.length_cons, hwk_len, List.length_replicate]
        omega
      by_cases hout : C.output < 27 + k
      · have houtInstr : outInstr = mkInstr false (C.output + 2) 1 := if_pos hout
        rw [houtInstr, stepFn_mkInstr_false wpad (C.output + 2) 1 (by omega) (by omega)]
        rw [← hwpad_len, getD_append_last]
        have hlt_wk : C.output + 2 < (false :: true :: wk).length := by
          simp [hwk_len]; omega
        have hlt_one : 1 < (false :: true :: wk).length := by
          simp [hwk_len]
        have hpad_out : wpad.getD (C.output + 2) false = wk.getD C.output false := by
          rw [foldl_stepFn_getD_lt _ _ _ hlt_wk, getD_cons_two]
        have hpad_one : wpad.getD 1 false = true := by
          rw [foldl_stepFn_getD_lt _ _ _ hlt_one]
          rfl
        rw [hpad_out, hpad_one, Bool.and_true]
        rw [Circuit.eval, hwires]
        conv_rhs => rw [← List.take_append_drop k C.gates, List.foldl_append]
        rw [foldl_gateEvalFn_getD_lt wk (C.gates.drop k) C.output (by omega)]
      · have houtInstr : outInstr = mkInstr true 0 0 := if_neg hout
        rw [houtInstr, stepFn_mkInstr_true wpad 0 0 (by omega) (by omega)]
        rw [← hwpad_len, getD_append_last]
        have hlt_zero : 0 < (false :: true :: wk).length := by simp
        have hpad_zero : wpad.getD 0 false = false := by
          rw [foldl_stepFn_getD_lt _ _ _ hlt_zero]
          rfl
        rw [hpad_zero, Bool.or_self]
        rw [Circuit.eval, hwires]
        have hlen_wires : (C.gates.foldl gateEvalFn x).length = 27 + C.gates.length := by
          rw [foldl_gateEvalFn_length, hx]
        have hge : (C.gates.foldl gateEvalFn x).length ≤ C.output := by
          have : C.gates.length ≤ 62 := hsize
          omega
        rw [getD_ge_length _ _ hge]
