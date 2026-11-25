import Mathlib
import PEqualNP.Defs

theorem PEqualNP.Outside.L_meta_7608 : ∀ (x1 : Type) (x2 x3 : List (Set x1)) (x4 : Set x1),   have x5 : ℕ → List (Set x1) := fun (x5 : ℕ) => x2 ++ List.take x5 x3;   x4 ∈ x2 ++ x3 → (∀ x7 ∈ x2, ¬x7 ⊆ x4) → (∀ (x8 : Fin x3.length), ∃ x9 ∈ x5 ↑x8, ∃ x10 ∈ x5 ↑x8, x3.get x8 = x9 ∪ x10 ∨ x3.get x8 = x9 ∩ x10) → ∀ x9 ∈ x4, ∃ (x11 : Fin x3.length), x3.get x11 ⊆ x4 ∧ x9 ∈ x3.get x11 ∧ ∃ x12 ∈ x5 ↑x11, ∃ x13 ∈ x5 ↑x11, ¬x12 ⊆ x4 ∧ ¬x13 ⊆ x4 ∧ x3.get x11 = x12 ∩ x13 := by
  intro X src T out prev hout hsrc hstep x hx
  have mem_get : ∀ (L : List (Set X)) (y : Set X),
      y ∈ L → ∃ (j : Fin L.length), L.get j = y := by
    intro L
    induction L with
    | nil =>
      intro y hy
      cases hy
    | cons hd tl ih =>
      intro y hy
      rcases List.mem_cons.mp hy with rfl | hy
      · exact ⟨⟨0, Nat.zero_lt_succ _⟩, rfl⟩
      · obtain ⟨j, hget⟩ := ih y hy
        exact ⟨⟨j.val + 1, Nat.succ_lt_succ j.isLt⟩, hget⟩
  have mem_take_get : ∀ (L : List (Set X)) (k : ℕ) (y : Set X),
      y ∈ List.take k L → ∃ (j : Fin L.length), j.val < k ∧ L.get j = y := by
    intro L
    induction L with
    | nil =>
      intro k y hy
      cases k <;> cases hy
    | cons hd tl ih =>
      intro k y hy
      cases k with
      | zero => cases hy
      | succ k =>
        rcases List.mem_cons.mp hy with rfl | hy
        · exact ⟨⟨0, Nat.zero_lt_succ _⟩, Nat.zero_lt_succ _, rfl⟩
        · obtain ⟨j, hj, hget⟩ := ih k y hy
          exact ⟨⟨j.val + 1, Nat.succ_lt_succ j.isLt⟩, Nat.succ_lt_succ hj, hget⟩
  have prev_idx : ∀ (k : ℕ) (y : Set X),
      y ∈ prev k → y ⊆ out → ∃ (j : Fin T.length), j.val < k ∧ T.get j = y := by
    intro k y hy hsub
    change y ∈ src ++ List.take k T at hy
    rcases List.mem_append.mp hy with hiny | hiny
    · exfalso
      exact hsrc y hiny hsub
    · exact mem_take_get T k y hiny
  have main : ∀ (n : ℕ) (j : Fin T.length), j.val < n → T.get j ⊆ out → x ∈ T.get j →
      ∃ (i : Fin T.length), T.get i ⊆ out ∧ x ∈ T.get i ∧
        ∃ a ∈ prev ↑i, ∃ b ∈ prev ↑i, ¬a ⊆ out ∧ ¬b ⊆ out ∧ T.get i = a ∩ b := by
    intro n
    induction n with
    | zero =>
      intro j hj
      exact False.elim (Nat.not_lt_zero j.val hj)
    | succ n ih =>
      intro j hj hsub hxj
      have step_prev : ∀ (y : Set X), y ∈ prev ↑j → y ⊆ out → x ∈ y →
          ∃ (i : Fin T.length), T.get i ⊆ out ∧ x ∈ T.get i ∧
            ∃ a ∈ prev ↑i, ∃ b ∈ prev ↑i, ¬a ⊆ out ∧ ¬b ⊆ out ∧ T.get i = a ∩ b := by
        intro y hy hysub hxy
        obtain ⟨j', hj', hget⟩ := prev_idx j.val y hy hysub
        exact ih j' (by omega) (by rw [hget]; exact hysub) (by rw [hget]; exact hxy)
      obtain ⟨a, ha, b, hb, hgate⟩ := hstep j
      rcases hgate with hunion | hinter
      · have hxab : x ∈ a ∪ b := by rw [← hunion]; exact hxj
        rcases hxab with hxa | hxb
        · have hasub : a ⊆ out := by
            intro z hz
            apply hsub
            rw [hunion]
            exact Or.inl hz
          exact step_prev a ha hasub hxa
        · have hbsub : b ⊆ out := by
            intro z hz
            apply hsub
            rw [hunion]
            exact Or.inr hz
          exact step_prev b hb hbsub hxb
      · have hxab : x ∈ a ∩ b := by rw [← hinter]; exact hxj
        by_cases hasub : a ⊆ out
        · exact step_prev a ha hasub hxab.1
        · by_cases hbsub : b ⊆ out
          · exact step_prev b hb hbsub hxab.2
          · exact ⟨j, hsub, hxj, a, ha, b, hb, hasub, hbsub, hinter⟩
  rcases List.mem_append.mp hout with hsrc_out | hT_out
  · exfalso
    exact hsrc out hsrc_out (fun z hz => hz)
  · obtain ⟨j, hget⟩ := mem_get T out hT_out
    exact main (j.val + 1) j (Nat.lt_succ_self j.val)
      (by rw [hget])
      (hget.symm ▸ hx)
