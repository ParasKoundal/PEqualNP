import Mathlib
import PEqualNP.Defs

namespace PEqualNP.Outside.L_meta_5950

open PEqualNP.CircuitLowerBounds PEqualNP.MetaComplexity.NestedCover

def stepWire (w : List Bool) (g : Gate) : List Bool :=
  w ++ [g.op.eval (g.inputs.map fun i => w.getD i false)]

lemma wires_eq_foldl (C : Circuit) (x : List Bool) :
    C.wires x = C.gates.foldl stepWire x := rfl

lemma foldl_length (gs : List Gate) (w : List Bool) :
    (gs.foldl stepWire w).length = w.length + gs.length := by
  induction gs generalizing w with
  | nil => simp
  | cons g gs ih =>
    rw [List.foldl_cons, ih]
    simp [stepWire]
    omega

lemma foldl_getD_lt (gs : List Gate) (w : List Bool) (i : ℕ) (hi : i < w.length) :
    (gs.foldl stepWire w).getD i false = w.getD i false := by
  induction gs generalizing w with
  | nil => rfl
  | cons g gs ih =>
    simp only [List.foldl_cons]
    have hlt : i < (stepWire w g).length := by simp [stepWire]; omega
    rw [ih (stepWire w g) hlt]
    simp [stepWire, List.getD_eq_getElem?_getD, List.getElem?_append_left hi]

lemma getD_ge (w : List Bool) (i : ℕ) (hi : w.length ≤ i) : w.getD i false = false := by
  simp [List.getD_eq_getElem?_getD, List.getElem?_eq_none hi]

lemma foldl_getD_gate (gs : List Gate) (w : List Bool) (j : ℕ) (hj : j < gs.length) :
    (gs.foldl stepWire w).getD (w.length + j) false =
      (gs[j]).op.eval ((gs[j]).inputs.map fun i =>
        if i < w.length + j then (gs.foldl stepWire w).getD i false else false) := by
  induction gs generalizing w j with
  | nil => simp at hj
  | cons g gs ih =>
    rw [List.foldl_cons]
    cases j with
    | zero =>
      have h1 : w.length < (stepWire w g).length := by simp [stepWire]
      rw [Nat.add_zero, foldl_getD_lt gs (stepWire w g) w.length h1]
      simp only [List.getElem_cons_zero]
      have h2 : (stepWire w g).getD w.length false =
          g.op.eval (g.inputs.map fun i => w.getD i false) := by
        simp [stepWire, List.getD_eq_getElem?_getD]
      rw [h2]
      congr 1
      apply List.map_congr_left
      intro i _
      by_cases hi : i < w.length
      · rw [if_pos hi, foldl_getD_lt gs (stepWire w g) i (by simp [stepWire]; omega)]
        simp [stepWire, List.getD_eq_getElem?_getD, List.getElem?_append_left hi]
      · rw [if_neg hi]; exact getD_ge w i (by omega)
    | succ j =>
      have hj' : j < gs.length := by simpa using hj
      have key := ih (stepWire w g) j hj'
      have hl : (stepWire w g).length = w.length + 1 := by simp [stepWire]
      rw [hl] at key
      have e : w.length + (j + 1) = w.length + 1 + j := by omega
      simp only [List.getElem_cons_succ]
      rw [e]
      exact key

def val (C : Circuit) (x : List Bool) (u : ℕ) : Bool := (C.wires x).getD u false

lemma eval_eq_val (C : Circuit) (x : List Bool) : C.eval x = val C x C.output := rfl

lemma gateAt_eq {C : Circuit} {j : ℕ} (hj : j < C.gates.length) : gateAt C j = C.gates[j] := by
  simp [gateAt, List.getD_eq_getElem?_getD, hj]

lemma gateAt_mem {C : Circuit} {j : ℕ} (hj : j < C.gates.length) : gateAt C j ∈ C.gates := by
  rw [gateAt_eq hj]; exact List.getElem_mem hj

lemma val_input {n : ℕ} {C : Circuit} {x : List Bool} (hx : x.length = n) {u : ℕ} (hu : u < n) :
    val C x u = x.getD u false := by
  unfold val; rw [wires_eq_foldl]; exact foldl_getD_lt _ _ _ (by omega)

lemma val_ge {n : ℕ} {C : Circuit} {x : List Bool} (hx : x.length = n) {u : ℕ}
    (hu : n + C.gates.length ≤ u) : val C x u = false := by
  unfold val; apply getD_ge; rw [wires_eq_foldl, foldl_length]; omega

lemma val_gate {n : ℕ} {C : Circuit} {x : List Bool} (hx : x.length = n) {j : ℕ}
    (hj : j < C.gates.length) :
    val C x (n + j) = (gateAt C j).op.eval ((gateAt C j).inputs.map fun i =>
      if i < n + j then val C x i else false) := by
  subst hx
  rw [gateAt_eq hj]
  exact foldl_getD_gate C.gates x j hj

lemma val_or {n : ℕ} {C : Circuit} {x : List Bool} (hx : x.length = n) {r : ℕ}
    (hr : r < C.gates.length) (hop : (gateAt C r).op = GateOp.or) :
    val C x (n + r) = true ↔ ∃ i ∈ (gateAt C r).inputs, i < n + r ∧ val C x i = true := by
  rw [val_gate hx hr, hop]
  simp only [GateOp.eval, List.any_map, List.any_eq_true, Function.comp_apply, id_eq]
  constructor
  · rintro ⟨i, hi, h⟩
    by_cases hlt : i < n + r
    · rw [if_pos hlt] at h; exact ⟨i, hi, hlt, h⟩
    · rw [if_neg hlt] at h; cases h
  · rintro ⟨i, hi, hlt, h⟩
    exact ⟨i, hi, by rw [if_pos hlt]; exact h⟩

lemma val_and {n : ℕ} {C : Circuit} {x : List Bool} (hx : x.length = n) {r : ℕ}
    (hr : r < C.gates.length) (hop : (gateAt C r).op = GateOp.and) :
    val C x (n + r) = true ↔ ∀ i ∈ (gateAt C r).inputs, i < n + r ∧ val C x i = true := by
  rw [val_gate hx hr, hop]
  simp only [GateOp.eval, List.all_map, List.all_eq_true, Function.comp_apply, id_eq]
  constructor
  · intro h i hi
    have h' := h i hi
    by_cases hlt : i < n + r
    · rw [if_pos hlt] at h'; exact ⟨hlt, h'⟩
    · rw [if_neg hlt] at h'; cases h'
  · intro h i hi
    rw [if_pos (h i hi).1]; exact (h i hi).2

lemma biclique_star {n : ℕ} (G : SimpleGraph (Fin n))
    (h4 : ∀ a b c d : Fin n, a ≠ c → b ≠ d →
      ¬ (G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a))
    (A B : Finset (Fin n)) (hab : ∀ a ∈ A, ∀ b ∈ B, G.Adj a b) :
    A.card ≤ 1 ∨ B.card ≤ 1 := by
  by_contra hcon
  simp only [not_or, not_le] at hcon
  obtain ⟨a, ha, c, hc, hac⟩ := Finset.one_lt_card.mp hcon.1
  obtain ⟨b, hb, d, hd, hbd⟩ := Finset.one_lt_card.mp hcon.2
  exact h4 a b c d hac hbd
    ⟨hab a ha b hb, (hab c hc b hb).symm, hab c hc d hd, (hab a ha d hd).symm⟩

lemma val_ofFn {n : ℕ} (C : Circuit) (x : Fin n → Bool) (u : Fin n) :
    val C (List.ofFn x) u.val = x u := by
  rw [val_input (n := n) (by simp) u.isLt]
  simp [List.getD_eq_getElem?_getD]

lemma gateVal_eq_val (n : ℕ) (C : Circuit) (j : ℕ) (x : Fin n → Bool) :
    PEqualNP.EdgeOwnership.gateVal n C j x = val C (List.ofFn x) (n + j) := rfl

open PEqualNP.EdgeOwnership

lemma cones_len (n : ℕ) (gs : List Gate) (cs : List (List ℕ)) :
    (gs.foldl (coneStep n) cs).length = cs.length + gs.length := by
  induction gs generalizing cs with
  | nil => simp
  | cons g gs ih =>
    rw [List.foldl_cons, ih]
    simp [coneStep]
    omega

lemma cones_char (n : ℕ) (gs : List Gate) :
    ∀ i j, i ∈ (gs.foldl (coneStep n) []).getD j [] ↔
      j < gs.length ∧ ∃ w ∈ (gs.getD j ⟨GateOp.or, []⟩).inputs, n ≤ w ∧ w < n + j ∧
        (i = w - n ∨ i ∈ (gs.foldl (coneStep n) []).getD (w - n) []) := by
  induction gs using List.reverseRecOn with
  | nil => intro i j; simp
  | append_singleton gs g ih =>
    intro i j
    rw [List.foldl_append, List.foldl_cons, List.foldl_nil]
    have hlen : (gs.foldl (coneStep n) []).length = gs.length := by
      rw [cones_len]; simp
    have key : ∀ k, k < gs.length →
        (coneStep n (gs.foldl (coneStep n) []) g).getD k [] =
          (gs.foldl (coneStep n) []).getD k [] := by
      intro k hk
      simp only [coneStep, List.getD_eq_getElem?_getD]
      rw [List.getElem?_append_left (by omega)]
    rcases Nat.lt_trichotomy j gs.length with h | h | h
    · have e1 : (gs ++ [g]).getD j ⟨GateOp.or, []⟩ = gs.getD j ⟨GateOp.or, []⟩ := by
        simp only [List.getD_eq_getElem?_getD]
        rw [List.getElem?_append_left h]
      rw [key j h, ih i j, e1]
      constructor
      · rintro ⟨_, w, hw, h1, h2, h3⟩
        refine ⟨by simp; omega, w, hw, h1, h2, ?_⟩
        rw [key (w - n) (by omega)]
        exact h3
      · rintro ⟨_, w, hw, h1, h2, h3⟩
        refine ⟨h, w, hw, h1, h2, ?_⟩
        rw [key (w - n) (by omega)] at h3
        exact h3
    · subst h
      have e1 : (gs ++ [g]).getD gs.length ⟨GateOp.or, []⟩ = g := by
        simp [List.getD_eq_getElem?_getD]
      have e2 : (coneStep n (gs.foldl (coneStep n) []) g).getD gs.length [] =
          (g.inputs.filter (fun w => decide (n ≤ w ∧ w < n + gs.length))).flatMap
            (fun w => (w - n) :: (gs.foldl (coneStep n) []).getD (w - n) []) := by
        simp only [coneStep, List.getD_eq_getElem?_getD]
        rw [List.getElem?_append_right (by omega)]
        simp [hlen]
      rw [e2, e1]
      simp only [List.mem_flatMap, List.mem_filter, List.mem_cons, decide_eq_true_eq]
      constructor
      · rintro ⟨w, ⟨hw, h1, h2⟩, h3⟩
        refine ⟨by simp, w, hw, h1, h2, ?_⟩
        rw [key (w - n) (by omega)]
        exact h3
      · rintro ⟨_, w, hw, h1, h2, h3⟩
        rw [key (w - n) (by omega)] at h3
        exact ⟨w, ⟨hw, h1, h2⟩, h3⟩
    · have e0 : (coneStep n (gs.foldl (coneStep n) []) g).getD j [] = [] := by
        simp only [coneStep, List.getD_eq_getElem?_getD]
        rw [List.getElem?_eq_none (by simp; omega)]
        rfl
      rw [e0]
      constructor
      · intro h0; simp at h0
      · rintro ⟨h0, _⟩
        simp at h0
        omega

lemma inCone_iff (n : ℕ) (C : Circuit) (i j : ℕ) :
    InCone n C i j ↔ j < C.gates.length ∧ ∃ k, k < j ∧ n + k ∈ (gateAt C j).inputs ∧
      (i = k ∨ InCone n C i k) := by
  have h := cones_char n C.gates i j
  unfold InCone cones gateAt
  rw [h]
  constructor
  · rintro ⟨h0, w, hw, h1, h2, h3⟩
    refine ⟨h0, w - n, by omega, ?_, h3⟩
    have : n + (w - n) = w := by omega
    rw [this]
    exact hw
  · rintro ⟨h0, k, hk, hw, h3⟩
    refine ⟨h0, n + k, hw, by omega, by omega, ?_⟩
    have : n + k - n = k := by omega
    rw [this]
    exact h3

lemma no4 {n : ℕ} (G : SimpleGraph (Fin n))
    (hg : ∀ (v : Fin n) (p : G.Walk v v), p.IsCycle → 5 ≤ p.length)
    (a b c d : Fin n) (hab : G.Adj a b) (hbc : G.Adj b c) (hcd : G.Adj c d) (hda : G.Adj d a)
    (hac : a ≠ c) (hbd : b ≠ d) : False := by
  have e1 := G.ne_of_adj hab
  have e2 := G.ne_of_adj hbc
  have e3 := G.ne_of_adj hcd
  have e4 := G.ne_of_adj hda
  have hcyc : (SimpleGraph.Walk.cons hab (SimpleGraph.Walk.cons hbc
      (SimpleGraph.Walk.cons hcd (SimpleGraph.Walk.cons hda SimpleGraph.Walk.nil)))).IsCycle := by
    rw [SimpleGraph.Walk.cons_isCycle_iff]
    refine ⟨?_, ?_⟩
    · simp [SimpleGraph.Walk.cons_isPath_iff, e1, e2, e3, e4, hac, hbd, Ne.symm e1, Ne.symm e2,
        Ne.symm e3, Ne.symm e4, Ne.symm hac, Ne.symm hbd]
    · simp [Sym2.eq_iff, e1, e2, e3, e4, hac, hbd, Ne.symm e1, Ne.symm e2,
        Ne.symm e3, Ne.symm e4, Ne.symm hac, Ne.symm hbd]
  have h5 := hg a _ hcyc
  simp at h5

inductive OrR (n : ℕ) (C : Circuit) (v : ℕ) : ℕ → Prop
  | base : OrR n C v v
  | step (i w' : ℕ) : i < C.gates.length → (gateAt C i).op = GateOp.or →
      w' ∈ (gateAt C i).inputs → w' < n + i → OrR n C v w' → OrR n C v (n + i)

lemma orR_val {n : ℕ} {C : Circuit} {x : List Bool} (hx : x.length = n) {v w : ℕ}
    (h : OrR n C v w) (hv : val C x v = true) : val C x w = true := by
  induction h with
  | base => exact hv
  | step i w' hi hop hmem hlt _ ih =>
    exact (val_or hx hi hop).mpr ⟨w', hmem, hlt, ih⟩

lemma orR_lt {n : ℕ} {C : Circuit} {v w : ℕ} (h : OrR n C v w) (hw : w < n) : w = v := by
  cases h with
  | base => rfl
  | step i w' hi hop hmem hlt h' => omega

lemma orR_ge {n : ℕ} {C : Circuit} {v w : ℕ} (h : OrR n C v w) (hv : v < n) (hw : n ≤ w) :
    ∃ i, w = n + i ∧ i < C.gates.length ∧ (gateAt C i).op = GateOp.or ∧
      ∃ w' ∈ (gateAt C i).inputs, w' < n + i ∧ OrR n C v w' := by
  cases h with
  | base => omega
  | step i w' hi hop hmem hlt h' => exact ⟨i, rfl, hi, hop, w', hmem, hlt, h'⟩

lemma inCone_lt (n : ℕ) (C : Circuit) : ∀ (j i : ℕ), InCone n C i j → i < j := by
  intro j
  induction j using Nat.strong_induction_on with
  | _ j ih =>
    intro i h
    obtain ⟨_, k, hk, _, h3⟩ := (inCone_iff n C i j).mp h
    rcases h3 with rfl | h3
    · exact hk
    · exact lt_trans (ih k hk i h3) hk

lemma pair_key {n : ℕ} {C : Circuit} (hM : PEqualNP.MetaComplexity.Monotone2 C) (u v : Fin n) :
    ∀ w : ℕ, val C (List.ofFn (pairInput u v)) w = true →
      (∀ i, (w = n + i ∨ (n ≤ w ∧ InCone n C i (w - n))) → (gateAt C i).op = GateOp.and →
        val C (List.ofFn (pairInput u v)) (n + i) = false) →
      OrR n C u.val w ∨ OrR n C v.val w := by
  intro w
  induction w using Nat.strong_induction_on with
  | _ w ih =>
    intro hval hno
    by_cases hw : w < n
    · have h1 := val_ofFn C (pairInput u v) ⟨w, hw⟩
      simp only [] at h1
      rw [hval] at h1
      have h2 : (⟨w, hw⟩ : Fin n) = u ∨ (⟨w, hw⟩ : Fin n) = v := by
        simpa [pairInput] using h1.symm
      rcases h2 with h2 | h2
      · left
        have : w = u.val := congrArg Fin.val h2
        rw [this]; exact OrR.base
      · right
        have : w = v.val := congrArg Fin.val h2
        rw [this]; exact OrR.base
    · obtain ⟨i, rfl⟩ : ∃ i, w = n + i := ⟨w - n, by omega⟩
      by_cases hi : i < C.gates.length
      · have hop := (hM _ (gateAt_mem hi)).1
        rcases hop with hop | hop
        · have := hno i (Or.inl rfl) hop
          rw [this] at hval; cases hval
        · have hop' : (gateAt C i).op = GateOp.or := hop
          obtain ⟨w', hmem, hlt, hv'⟩ := (val_or (n := n) (by simp) hi hop').mp hval
          have hno' : ∀ i', (w' = n + i' ∨ (n ≤ w' ∧ InCone n C i' (w' - n))) →
              (gateAt C i').op = GateOp.and →
              val C (List.ofFn (pairInput u v)) (n + i') = false := by
            intro i' hi' hand
            apply hno i' _ hand
            right
            refine ⟨by omega, ?_⟩
            have e : n + i - n = i := by omega
            rw [e, inCone_iff]
            refine ⟨hi, w' - n, by omega, ?_, ?_⟩
            · have : n + (w' - n) = w' := by omega
              rw [this]; exact hmem
            · rcases hi' with h | h
              · left; omega
              · right; exact h.2
          rcases ih w' hlt hv' hno' with h | h
          · exact Or.inl (OrR.step i w' hi hop' hmem hlt h)
          · exact Or.inr (OrR.step i w' hi hop' hmem hlt h)
      · have := val_ge (C := C) (x := List.ofFn (pairInput u v)) (n := n) (by simp)
          (u := n + i) (by omega)
        rw [this] at hval; cases hval

lemma owner_inputs {n : ℕ} {C : Circuit} (hM : PEqualNP.MetaComplexity.Monotone2 C)
    {j : ℕ} {u v : Fin n} (h : Owns n C j u v) :
    ∀ w ∈ (gateAt C j).inputs, w < n + j ∧ (OrR n C u.val w ∨ OrR n C v.val w) := by
  obtain ⟨hj, hop, hval, hno⟩ := h
  rw [gateVal_eq_val] at hval
  have hall := (val_and (n := n) (by simp) hj hop).mp hval
  intro w hw
  obtain ⟨hlt, hv⟩ := hall w hw
  refine ⟨hlt, pair_key hM u v w hv ?_⟩
  intro i hi hand
  have hcone : InCone n C i j := by
    rw [inCone_iff]
    refine ⟨hj, w - n, ?_, ?_, ?_⟩
    · rcases hi with h | h <;> omega
    · have : n + (w - n) = w := by rcases hi with h | h <;> omega
      rw [this]; exact hw
    · rcases hi with h | h
      · left; omega
      · right; exact h.2
  have := hno i (inCone_lt n C j i hcone) hcone hand
  rw [gateVal_eq_val] at this
  exact this

lemma and_true {n : ℕ} {C : Circuit} {j : ℕ} (hj : j < C.gates.length)
    (hop : (gateAt C j).op = GateOp.and) (w w' : Fin n)
    (h : ∀ c ∈ (gateAt C j).inputs, c < n + j ∧ (OrR n C w.val c ∨ OrR n C w'.val c)) :
    gateVal n C j (pairInput w w') = true := by
  rw [gateVal_eq_val]
  refine (val_and (n := n) (by simp) hj hop).mpr ?_
  intro c hc
  obtain ⟨hlt, hor⟩ := h c hc
  refine ⟨hlt, ?_⟩
  rcases hor with hor | hor
  · exact orR_val (n := n) (by simp) hor (by rw [val_ofFn]; simp [pairInput])
  · exact orR_val (n := n) (by simp) hor (by rw [val_ofFn]; simp [pairInput])

open Classical in
noncomputable def RV (n : ℕ) (C : Circuit) (V : Finset (Fin n)) (w : ℕ) : Finset (Fin n) :=
  V.filter fun u => OrR n C u.val w

lemma mem_RV {n : ℕ} {C : Circuit} {V : Finset (Fin n)} {w : ℕ} {u : Fin n} :
    u ∈ RV n C V w ↔ u ∈ V ∧ OrR n C u.val w := by
  simp [RV]

lemma RV_input_card {n : ℕ} {C : Circuit} {V : Finset (Fin n)} {w : ℕ} (hw : w < n) :
    (RV n C V w).card ≤ 1 := by
  rw [Finset.card_le_one]
  intro a ha b hb
  have h1 := orR_lt (mem_RV.mp ha).2 hw
  have h2 := orR_lt (mem_RV.mp hb).2 hw
  exact Fin.ext (by omega)

lemma configV {n : ℕ} {C : Circuit} (G : SimpleGraph (Fin n))
    (hM : PEqualNP.MetaComplexity.Monotone2 C)
    {j : ℕ} {u v : Fin n} (hown : Owns n C j u v) (V : Finset (Fin n))
    (hu : u ∈ V) (hv : v ∈ V)
    (hV : ∀ w ∈ V, ∀ w' ∈ V, gateVal n C j (pairInput w w') = true → G.Adj w w') :
    ∃ a b, ((gateAt C j).inputs = [a, b] ∨ (gateAt C j).inputs = [b, a]) ∧
      u ∈ RV n C V a ∧ v ∈ RV n C V b ∧
      ∀ w ∈ RV n C V a, ∀ w' ∈ RV n C V b, G.Adj w w' := by
  have hall := owner_inputs hM hown
  have hj := hown.1
  have hop := hown.2.1
  have hlen := (hM _ (gateAt_mem hj)).2
  have H : ∀ w ∈ V, ∀ w' ∈ V,
      (∀ c ∈ (gateAt C j).inputs, OrR n C w.val c ∨ OrR n C w'.val c) → G.Adj w w' := by
    intro w hw w' hw' hc
    exact hV w hw w' hw' (and_true hj hop w w' (fun c hcm => ⟨(hall c hcm).1, hc c hcm⟩))
  generalize hL : (gateAt C j).inputs = L at hall hlen H
  match L, hlen with
  | [], _ =>
    exact absurd (H u hu u hu (by simp)) (G.loopless.irrefl u)
  | [a], _ =>
    rcases (hall a (by simp)).2 with h | h
    · exact absurd (H u hu u hu (by simpa using h)) (G.loopless.irrefl u)
    · exact absurd (H v hv v hv (by simpa using h)) (G.loopless.irrefl v)
  | [a, b], _ =>
    rcases (hall a (by simp)).2 with ha | ha <;> rcases (hall b (by simp)).2 with hb | hb
    · exact absurd (H u hu u hu (by simp [ha, hb])) (G.loopless.irrefl u)
    · refine ⟨a, b, Or.inl rfl, mem_RV.mpr ⟨hu, ha⟩, mem_RV.mpr ⟨hv, hb⟩, ?_⟩
      intro w hw w' hw'
      exact H w (mem_RV.mp hw).1 w' (mem_RV.mp hw').1
        (by simp [(mem_RV.mp hw).2, (mem_RV.mp hw').2])
    · refine ⟨b, a, Or.inr rfl, mem_RV.mpr ⟨hu, hb⟩, mem_RV.mpr ⟨hv, ha⟩, ?_⟩
      intro w hw w' hw'
      exact H w (mem_RV.mp hw).1 w' (mem_RV.mp hw').1
        (by simp [(mem_RV.mp hw).2, (mem_RV.mp hw').2])
    · exact absurd (H v hv v hv (by simp [ha, hb])) (G.loopless.irrefl v)
  | _ :: _ :: _ :: _, h => simp at h

def IsMin {n : ℕ} (C : Circuit) (V : Finset (Fin n)) (w : ℕ) (v0 : Fin n) : Prop :=
  v0 ∈ RV n C V w ∧ ∀ z ∈ RV n C V w, v0 ≤ z

lemma isMin_unique {n : ℕ} {C : Circuit} {V : Finset (Fin n)} {w : ℕ} {v1 v2 : Fin n}
    (h1 : IsMin C V w v1) (h2 : IsMin C V w v2) : v1 = v2 :=
  le_antisymm (h1.2 v2 h2.1) (h2.2 v1 h1.1)

lemma isMin_of_card_le_one {n : ℕ} {C : Circuit} {V : Finset (Fin n)} {w : ℕ} {u : Fin n}
    (hu : u ∈ RV n C V w) (hc : (RV n C V w).card ≤ 1) : IsMin C V w u := by
  refine ⟨hu, fun z hz => ?_⟩
  have := Finset.card_le_one.mp hc u hu z hz
  rw [this]

lemma exists_isMin {n : ℕ} {C : Circuit} {V : Finset (Fin n)} {w : ℕ} {v0 : Fin n}
    (hv0 : v0 ∈ RV n C V w) : ∃ m : Fin n, IsMin C V w m := by
  refine ⟨(RV n C V w).min' ⟨v0, hv0⟩, Finset.min'_mem _ _, fun z hz => Finset.min'_le _ z hz⟩

lemma descent_min {n : ℕ} {C : Circuit} {V : Finset (Fin n)} (v0 : Fin n) :
    ∀ w, v0 ∈ RV n C V w → ¬ IsMin C V w v0 →
      ∃ h, h < C.gates.length ∧ (gateAt C h).op = GateOp.or ∧
        RV n C V (n + h) ⊆ RV n C V w ∧ ¬ IsMin C V (n + h) v0 ∧
        ∃ c ∈ (gateAt C h).inputs, c < n + h ∧ IsMin C V c v0 := by
  intro w
  induction w using Nat.strong_induction_on with
  | _ w ih =>
    intro hv hnot
    by_cases hw : w < n
    · exact absurd (isMin_of_card_le_one hv (RV_input_card hw)) hnot
    · obtain ⟨i, rfl, hi, hop, w', hmem, hlt, hor'⟩ :=
        orR_ge (mem_RV.mp hv).2 v0.isLt (by omega)
      have hv' : v0 ∈ RV n C V w' := mem_RV.mpr ⟨(mem_RV.mp hv).1, hor'⟩
      by_cases hm : IsMin C V w' v0
      · exact ⟨i, hi, hop, subset_rfl, hnot, w', hmem, hlt, hm⟩
      · obtain ⟨h, h1, h2, h3, h4, h5⟩ := ih w' hlt hv' hm
        refine ⟨h, h1, h2, ?_, h4, h5⟩
        intro x hx
        have hx' := mem_RV.mp (h3 hx)
        exact mem_RV.mpr ⟨hx'.1, OrR.step i w' hi hop hmem hlt hx'.2⟩

def PA {n : ℕ} (C : Circuit) (V : Finset (Fin n)) (g : ℕ) (e : Sym2 (Fin n)) : Prop :=
  (gateAt C g).op = GateOp.and ∧ ∃ a b u v, (gateAt C g).inputs = [a, b] ∧
    IsMin C V a u ∧ IsMin C V b v ∧ e = s(u, v)

def PO {n : ℕ} (G : SimpleGraph (Fin n)) (C : Circuit) (V : Finset (Fin n)) (g : ℕ)
    (e : Sym2 (Fin n)) : Prop :=
  g < C.gates.length ∧ (gateAt C g).op = GateOp.or ∧
    ∃ u v, e = s(u, v) ∧ ¬ IsMin C V (n + g) v ∧
      (∀ w ∈ RV n C V (n + g), G.Adj u w) ∧
      ∃ c ∈ (gateAt C g).inputs, c < n + g ∧ IsMin C V c v

lemma charge_aux {n : ℕ} {C : Circuit} (G : SimpleGraph (Fin n)) (V : Finset (Fin n)) (j : ℕ)
    (hj : j < C.gates.length) (hop : (gateAt C j).op = GateOp.and)
    (a b : ℕ) (u v : Fin n)
    (hin : (gateAt C j).inputs = [a, b] ∨ (gateAt C j).inputs = [b, a])
    (hua : u ∈ RV n C V a) (hvb : v ∈ RV n C V b)
    (hbi : ∀ w ∈ RV n C V a, ∀ w' ∈ RV n C V b, G.Adj w w')
    (hA : (RV n C V a).card ≤ 1) :
    ∃ g < C.gates.length, PA C V g s(u, v) ∨ PO G C V g s(u, v) := by
  have hma : IsMin C V a u := isMin_of_card_le_one hua hA
  by_cases hmb : IsMin C V b v
  · refine ⟨j, hj, Or.inl ⟨hop, ?_⟩⟩
    rcases hin with hin | hin
    · exact ⟨a, b, u, v, hin, hma, hmb, rfl⟩
    · exact ⟨b, a, v, u, hin, hmb, hma, Sym2.eq_swap⟩
  · obtain ⟨h, h1, h2, h3, h4, c, hc, hclt, hmc⟩ := descent_min v b hvb hmb
    refine ⟨h, h1, Or.inr ⟨h1, h2, u, v, rfl, h4, ?_, c, hc, hclt, hmc⟩⟩
    intro w hw
    exact hbi u hua w (h3 hw)

lemma charge {n : ℕ} {C : Circuit} (G : SimpleGraph (Fin n))
    (h4 : ∀ a b c d : Fin n, a ≠ c → b ≠ d →
      ¬ (G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a))
    (V : Finset (Fin n)) (j : ℕ)
    (hj : j < C.gates.length) (hop : (gateAt C j).op = GateOp.and)
    (a b : ℕ) (u v : Fin n)
    (hin : (gateAt C j).inputs = [a, b] ∨ (gateAt C j).inputs = [b, a])
    (hua : u ∈ RV n C V a) (hvb : v ∈ RV n C V b)
    (hbi : ∀ w ∈ RV n C V a, ∀ w' ∈ RV n C V b, G.Adj w w') :
    ∃ g < C.gates.length, PA C V g s(u, v) ∨ PO G C V g s(u, v) := by
  rcases biclique_star G h4 (RV n C V a) (RV n C V b) hbi with hA | hB
  · exact charge_aux G V j hj hop a b u v hin hua hvb hbi hA
  · have := charge_aux G V j hj hop b a v u hin.symm hvb hua
      (fun w hw w' hw' => (hbi w' hw' w hw).symm) hB
    rw [Sym2.eq_swap]
    exact this

lemma fibA {n : ℕ} {C : Circuit} (V : Finset (Fin n)) (g : ℕ) (S : Finset (Sym2 (Fin n)))
    (hS : ∀ e ∈ S, PA C V g e) : S.card ≤ 1 := by
  rw [Finset.card_le_one]
  intro e1 he1 e2 he2
  obtain ⟨_, a1, b1, u1, v1, hin1, hma1, hmb1, rfl⟩ := hS e1 he1
  obtain ⟨_, a2, b2, u2, v2, hin2, hma2, hmb2, rfl⟩ := hS e2 he2
  rw [hin1] at hin2
  simp only [List.cons.injEq, _root_.and_true] at hin2
  obtain ⟨rfl, rfl⟩ := hin2
  rw [isMin_unique hma1 hma2, isMin_unique hmb1 hmb2]

lemma fibO {n : ℕ} {C : Circuit} (G : SimpleGraph (Fin n))
    (h4 : ∀ a b c d : Fin n, a ≠ c → b ≠ d →
      ¬ (G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a))
    (hlen : ∀ g, (gateAt C g).inputs.length ≤ 2)
    (V : Finset (Fin n)) (g : ℕ) (S : Finset (Sym2 (Fin n)))
    (hS : ∀ e ∈ S, PO G C V g e) : S.card ≤ 1 := by
  rw [Finset.card_le_one]
  intro e1 he1 e2 he2
  obtain ⟨hg, hop, u1, v1, rfl, hnot1, hadj1, c1, hc1, hclt1, hmc1⟩ := hS e1 he1
  obtain ⟨_, _, u2, v2, rfl, hnot2, hadj2, c2, hc2, hclt2, hmc2⟩ := hS e2 he2
  have hv1 : v1 ∈ RV n C V (n + g) :=
    mem_RV.mpr ⟨(mem_RV.mp hmc1.1).1, OrR.step g c1 hg hop hc1 hclt1 (mem_RV.mp hmc1.1).2⟩
  obtain ⟨m, hm⟩ := exists_isMin hv1
  have hmv1 : m ≠ v1 := by rintro rfl; exact hnot1 hm
  obtain ⟨i, hi, _, _, c0, hc0, hc0lt, hor0⟩ := orR_ge (mem_RV.mp hm.1).2 m.isLt (by omega)
  have hig : i = g := by omega
  subst hig
  have hmc0 : IsMin C V c0 m := by
    refine ⟨mem_RV.mpr ⟨(mem_RV.mp hm.1).1, hor0⟩, fun z hz => hm.2 z ?_⟩
    exact mem_RV.mpr ⟨(mem_RV.mp hz).1, OrR.step i c0 hg hop hc0 hc0lt (mem_RV.mp hz).2⟩
  have hc10 : c1 ≠ c0 := by
    rintro rfl
    exact hmv1 (isMin_unique hmc0 hmc1)
  have hc20 : c2 ≠ c0 := by
    rintro rfl
    exact hnot2 (by rw [← isMin_unique hmc0 hmc2]; exact hm)
  have hc12 : c1 = c2 := by
    have hL := hlen i
    generalize hinputs : (gateAt C i).inputs = L at hc0 hc1 hc2 hL
    match L, hL with
    | [], _ => simp at hc0
    | [x], _ =>
      simp only [List.mem_singleton] at hc0 hc1
      exact absurd (hc1.trans hc0.symm) hc10
    | [x, y], _ =>
      simp only [List.mem_cons, List.not_mem_nil, or_false] at hc0 hc1 hc2
      rcases hc0 with rfl | rfl <;> rcases hc1 with rfl | rfl <;> rcases hc2 with rfl | rfl <;>
        first | rfl | exfalso; apply hc10 rfl | exfalso; apply hc20 rfl
    | _ :: _ :: _ :: _, h => simp at h
  subst hc12
  have hv12 : v1 = v2 := isMin_unique hmc1 hmc2
  subst hv12
  have hu12 : u1 = u2 := by
    by_contra hne
    exact h4 u1 v1 u2 m hne hmv1.symm
      ⟨hadj1 v1 hv1, (hadj2 v1 hv1).symm, hadj2 m hm.1, (hadj1 m hm.1).symm⟩
  rw [hu12]

lemma count {n : ℕ} {C : Circuit} (G : SimpleGraph (Fin n))
    (h4 : ∀ a b c d : Fin n, a ≠ c → b ≠ d →
      ¬ (G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a))
    (hlen : ∀ g, (gateAt C g).inputs.length ≤ 2)
    (V : Finset (Fin n)) (M : Finset (Sym2 (Fin n)))
    (hM : ∀ e ∈ M, ∃ g < C.gates.length, PA C V g e ∨ PO G C V g e) :
    M.card ≤ C.size := by
  classical
  have hsub : M ⊆ (Finset.range C.gates.length).biUnion
      (fun g => M.filter (fun e => PA C V g e ∨ PO G C V g e)) := by
    intro e he
    obtain ⟨g, hg, hP⟩ := hM e he
    exact Finset.mem_biUnion.mpr ⟨g, Finset.mem_range.mpr hg, Finset.mem_filter.mpr ⟨he, hP⟩⟩
  have hb := Finset.card_biUnion_le_card_mul (Finset.range C.gates.length)
      (fun g => M.filter (fun e => PA C V g e ∨ PO G C V g e)) 1 (by
    intro g _
    by_cases hop : (gateAt C g).op = GateOp.and
    · refine fibA (C := C) V g _ ?_
      intro e he
      rcases (Finset.mem_filter.mp he).2 with h | h
      · exact h
      · have := hop.symm.trans h.2.1
        cases this
    · refine fibO G h4 hlen V g _ ?_
      intro e he
      rcases (Finset.mem_filter.mp he).2 with h | h
      · exact absurd h.1 hop
      · exact h)
  have := Finset.card_le_card hsub
  rw [Finset.card_range, Nat.mul_one] at hb
  unfold Circuit.size
  exact le_trans this hb

end PEqualNP.Outside.L_meta_5950

theorem PEqualNP.Outside.L_meta_5950 : ∀ (x1 : ℕ) (x2 : SimpleGraph (Fin x1)) [x3 : DecidableRel x2.Adj], (∀ (x4 : Fin x1) (x5 : x2.Walk x4 x4), x5.IsCycle → (5 : ℕ) ≤ x5.length) → ∀ (x5 : PEqualNP.CircuitLowerBounds.Circuit), PEqualNP.MetaComplexity.Monotone2 x5 → ∀ (x7 : Finset (Fin x1)), ∀ x8 ⊆ x2.edgeFinset, (∀ x10 ∈ x8, ∃ x12 ∈ x7, ∃ x13 ∈ x7, x10 = s(x12, x13) ∧ ∃ (x14 : Fin x5.gates.length), PEqualNP.EdgeOwnership.Owns x1 x5 (↑x14) x12 x13 ∧ ∀ x15 ∈ x7, ∀ x17 ∈ x7, PEqualNP.EdgeOwnership.gateVal x1 x5 (↑x14) (PEqualNP.EdgeOwnership.pairInput x15 x17) = Bool.true → x2.Adj x15 x17) → x8.card ≤ x5.size := by
  intro n G _ hg C hMono V M _ hM
  have h4 : ∀ a b c d : Fin n, a ≠ c → b ≠ d →
      ¬ (G.Adj a b ∧ G.Adj b c ∧ G.Adj c d ∧ G.Adj d a) := by
    intro a b c d hac hbd h
    exact PEqualNP.Outside.L_meta_5950.no4 G hg a b c d h.1 h.2.1 h.2.2.1 h.2.2.2 hac hbd
  have hlen : ∀ g, (PEqualNP.MetaComplexity.NestedCover.gateAt C g).inputs.length ≤ 2 := by
    intro g
    by_cases hgl : g < C.gates.length
    · exact (hMono _ (PEqualNP.Outside.L_meta_5950.gateAt_mem hgl)).2
    · simp [PEqualNP.MetaComplexity.NestedCover.gateAt, List.getD_eq_getElem?_getD,
        List.getElem?_eq_none (not_lt.mp hgl)]
  apply PEqualNP.Outside.L_meta_5950.count G h4 hlen V M
  intro e he
  obtain ⟨u, hu, v, hv, rfl, j, hown, hV⟩ := hM e he
  obtain ⟨a, b, hin, hua, hvb, hbi⟩ :=
    PEqualNP.Outside.L_meta_5950.configV G hMono hown V hu hv hV
  exact PEqualNP.Outside.L_meta_5950.charge G h4 V j hown.1 hown.2.1 a b u v hin hua hvb hbi
