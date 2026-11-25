import Mathlib
import PEqualNP.Defs

theorem PEqualNP.Outside.L_meta_7606 : ∀ (x1 : Type) (x2 x3 x4 : ℕ) (x5 : ℕ → Set x1),   x4 < x2 + x3 →     x5 x4 ≠ ∅ →       (∀ x8 < x3, ∃ (x10 : ℕ) (x11 : ℕ), Max.max x10 x11 < x2 + x8 ∧ x5 (x2 + x8) ∈ [x5 x10 ∪ x5 x11, x5 x10, ∅, x5 x10 ∩ x5 x11]) →         ∃ (x9 : List ℕ),           x9.length ≤ x3 ∧             (∀ x10 ∈ x9, x2 ≤ x10 ∧ x10 < x2 + x3) ∧               x5 x4 ∈ List.map x5 (List.range x2 ++ x9) ∧                 ∀ (x10 : Fin x9.length),                   have x11 : List ℕ := List.range x2 ++ List.take (↑x10) x9;                   have x12 : Set x1 := x5 (x9.get x10);                   (∀ x13 ∈ x11, x13 < x9.get x10) ∧ x12 ≠ ∅ ∧ x12 ∉ List.map x5 x11 ∧ ∃ x13 ∈ List.map x5 x11, ∃ x14 ∈ List.map x5 x11, ¬x13 ⊆ x14 ∧ ¬x14 ⊆ x13 ∧ (x12 = x13 ∪ x14 ∨ x12 = x13 ∩ x14) := by
  intro X m s o W hout hne hstep
  have main :
      ∀ s : ℕ,
        (∀ i < s, ∃ a b : ℕ, max a b < m + i ∧
          W (m + i) ∈ [W a ∪ W b, W a, ∅, W a ∩ W b]) →
        ∃ T : List ℕ,
          T.length ≤ s ∧
          (∀ i ∈ T, m ≤ i ∧ i < m + s) ∧
          (∀ o < m + s, W o ≠ ∅ → W o ∈ List.map W (List.range m ++ T)) ∧
          ∀ j : Fin T.length,
            have pool : List ℕ := List.range m ++ List.take (↑j) T;
            have z : Set X := W (T.get j);
            (∀ w ∈ pool, w < T.get j) ∧ z ≠ ∅ ∧ z ∉ List.map W pool ∧
              ∃ a ∈ List.map W pool, ∃ b ∈ List.map W pool,
                ¬a ⊆ b ∧ ¬b ⊆ a ∧ (z = a ∪ b ∨ z = a ∩ b) := by
    intro s
    induction s with
    | zero =>
      intro _
      refine ⟨[], by simp, by simp, ?_, ?_⟩
      · intro o ho _
        have hlt : o < m := by omega
        exact List.mem_map_of_mem (f := W) (List.mem_append_left _ (List.mem_range.mpr hlt))
      · intro j
        exact Fin.elim0 j
    | succ s ih =>
      intro hstep_s
      obtain ⟨T, hlen, hbounds, hcov, hshape⟩ :=
        ih (fun i hi => hstep_s i (Nat.lt_succ_of_lt hi))
      by_cases hskip : W (m + s) = ∅ ∨ W (m + s) ∈ List.map W (List.range m ++ T)
      · refine ⟨T, by omega, ?_, ?_, hshape⟩
        · intro i hi
          obtain ⟨h1, h2⟩ := hbounds i hi
          exact ⟨h1, by omega⟩
        · intro o ho hne_o
          by_cases hlt : o < m + s
          · exact hcov o hlt hne_o
          · have heq : o = m + s := by omega
            rw [heq] at hne_o ⊢
            rcases hskip with hempty | hmem
            · exact False.elim (hne_o hempty)
            · exact hmem
      · have hne_ms : W (m + s) ≠ ∅ := fun h => hskip (Or.inl h)
        have hnotmem : W (m + s) ∉ List.map W (List.range m ++ T) := fun h => hskip (Or.inr h)
        obtain ⟨a, b, hmax, hgate⟩ := hstep_s s (Nat.lt_succ_self s)
        have ha_lt : a < m + s := (max_lt_iff.mp hmax).1
        have hb_lt : b < m + s := (max_lt_iff.mp hmax).2
        have hneq_prev : ∀ c < m + s, W (m + s) ≠ W c := by
          intro c hc heq
          apply hnotmem
          rw [heq]
          exact hcov c hc (by rw [← heq]; exact hne_ms)
        simp only [List.mem_cons, List.not_mem_nil, or_false] at hgate
        have hlaw : W (m + s) = W a ∪ W b ∨ W (m + s) = W a ∩ W b := by
          rcases hgate with h1 | h2 | h3 | h4
          · exact Or.inl h1
          · exact False.elim (hneq_prev a ha_lt h2)
          · exact False.elim (hne_ms h3)
          · exact Or.inr h4
        have ha_ne : W a ≠ ∅ := by
          intro ha0
          rcases hlaw with h1 | h2
          · rw [ha0, Set.empty_union] at h1
            exact hneq_prev b hb_lt h1
          · rw [ha0, Set.empty_inter] at h2
            exact hne_ms h2
        have hb_ne : W b ≠ ∅ := by
          intro hb0
          rcases hlaw with h1 | h2
          · rw [hb0, Set.union_empty] at h1
            exact hneq_prev a ha_lt h1
          · rw [hb0, Set.inter_empty] at h2
            exact hne_ms h2
        have ha_mem : W a ∈ List.map W (List.range m ++ T) := hcov a ha_lt ha_ne
        have hb_mem : W b ∈ List.map W (List.range m ++ T) := hcov b hb_lt hb_ne
        have hnot_ab : ¬W a ⊆ W b := by
          intro hab
          rcases hlaw with h1 | h2
          · have hu : W a ∪ W b = W b := by
              ext x; simp only [Set.mem_union]; exact ⟨fun h => h.elim (fun hx => hab hx) id, Or.inr⟩
            rw [hu] at h1
            exact hneq_prev b hb_lt h1
          · have hi : W a ∩ W b = W a := by
              ext x; simp only [Set.mem_inter_iff]; exact ⟨fun h => h.1, fun hx => ⟨hx, hab hx⟩⟩
            rw [hi] at h2
            exact hneq_prev a ha_lt h2
        have hnot_ba : ¬W b ⊆ W a := by
          intro hba
          rcases hlaw with h1 | h2
          · have hu : W a ∪ W b = W a := by
              ext x; simp only [Set.mem_union]; exact ⟨fun h => h.elim id (fun hx => hba hx), Or.inl⟩
            rw [hu] at h1
            exact hneq_prev a ha_lt h1
          · have hi : W a ∩ W b = W b := by
              ext x; simp only [Set.mem_inter_iff]; exact ⟨fun h => h.2, fun hx => ⟨hba hx, hx⟩⟩
            rw [hi] at h2
            exact hneq_prev b hb_lt h2
        refine ⟨T ++ [m + s], ?_, ?_, ?_, ?_⟩
        · rw [List.length_append, List.length_singleton]
          omega
        · intro i hi
          rcases List.mem_append.mp hi with hiT | hiS
          · obtain ⟨h1, h2⟩ := hbounds i hiT
            exact ⟨h1, by omega⟩
          · simp only [List.mem_singleton] at hiS
            rw [hiS]
            omega
        · intro o ho hne_o
          rw [← List.append_assoc, List.map_append]
          by_cases hlt : o < m + s
          · exact List.mem_append_left _ (hcov o hlt hne_o)
          · have heq : o = m + s := by omega
            rw [heq]
            exact List.mem_append_right _ (by simp)
        · intro j
          have hj_bound : j.val < T.length + 1 := by
            have h1 := j.isLt
            have h2 : (T ++ [m + s]).length = T.length + 1 := by simp
            omega
          by_cases hj : j.val < T.length
          · have htake : List.take j.val (T ++ [m + s]) = List.take j.val T :=
              List.take_append_of_le_length (Nat.le_of_lt hj)
            have hget : (T ++ [m + s]).get j = T.get ⟨j.val, hj⟩ := by
              change (T ++ [m + s])[j.val] = T[j.val]
              exact List.getElem_append_left hj
            dsimp only
            rw [htake, hget]
            exact hshape ⟨j.val, hj⟩
          · have hj_eq : j.val = T.length := by omega
            have hj_ge : T.length ≤ j.val := by omega
            have htake : List.take j.val (T ++ [m + s]) = T := by
              rw [hj_eq, List.take_append_of_le_length (le_refl _), List.take_length]
            have hget : (T ++ [m + s]).get j = m + s := by
              change (T ++ [m + s])[j.val] = m + s
              rw [List.getElem_append_right hj_ge]
              simp [hj_eq]
            dsimp only
            rw [htake, hget]
            refine ⟨?_, hne_ms, hnotmem, ⟨W a, ha_mem, W b, hb_mem, hnot_ab, hnot_ba, hlaw⟩⟩
            intro w hw
            rcases List.mem_append.mp hw with hwr | hwt
            · have hlt : w < m := List.mem_range.mp hwr
              omega
            · exact (hbounds w hwt).2
  obtain ⟨T, hlen, hbounds, hcov, hshape⟩ := main s hstep
  exact ⟨T, hlen, hbounds, hcov o hout hne, hshape⟩
