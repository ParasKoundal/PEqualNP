# P vs NP — Formal Lean 4 Proofs & Reductions (`ParasKoundal`)

This repository contains the standalone Lean 4 proofs and reductions contributed by **Paras Koundal** ([@paraskoundal](https://x.com/paraskoundal) / [LinkedIn](https://www.linkedin.com/in/paraskoundal/)) to the collaborative formal attack on $P \text{ vs } NP$ at [`open-goat/pequalnp-proofs`](https://github.com/open-goat/pequalnp-proofs) ([pequalnp.com](https://pequalnp.com)).

Rather than mirroring the entire upstream proof tree, this repository archives **only my contributed Lean 4 modules** alongside their live upstream pull request links, status, mathematical summary, and role in the global dependency DAG.

- **Contributor Profile**: [`https://pequalnp.com/a/ParasKoundal`](https://pequalnp.com/a/ParasKoundal)
- **Upstream Repository**: [`open-goat/pequalnp-proofs`](https://github.com/open-goat/pequalnp-proofs)
- **Lean 4 / Mathlib Toolchain**: `leanprover/lean4:v4.29.0-rc8` (`Mathlib` commit `556a2dad8f643dc2de3ff9adbd32cfa73ac83a39`)

---

## Summary Table of Contributions

- **Merged Upstream Proofs & Reductions**: **33**
- **In review upstream**: **50** open PRs from 2026-11-26 (see [In Review](#in-review)). Most are expected to close as duplicates.
- **Closed upstream PRs**: **290**. On 2026-11-26, 270 closed because another contributor's PR for the same step merged first (the checker accepted the proofs). Before that, 20 had closed: 12 were duplicates (another PR proved the step first), 3 timed out at 20 min (`L-meta-8035` was later merged through a faster PR, #13317, and `L-meta-6754` is being redone), 3 were for steps the desk withdrew, and 2 failed the format rules.
- **Lean 4 modules in this archive**: **55** in `proofs/lemmas` and `proofs/reductions`, plus **50** in `proofs/pending` (closed ones are kept for reference; only merged ones count on pequalnp.com)

| Step ID | Type | Weight | Depth | Local File | Upstream PR | Status | Title / Role in Global Proof Tree |
| :--- | :---: | :---: | :---: | :--- | :--- | :---: | :--- |
| **[`L-meta-21407`](https://pequalnp.com/s/L-meta-21407)** | Lemma (`L-*`) | — | 0 | [`proofs/lemmas/L_meta_21407.lean`](proofs/lemmas/L_meta_21407.lean) | [PR #28615](https://github.com/open-goat/pequalnp-proofs/pull/28615) | **MERGED** (`2026-11-26`) | 4×5 bipartite graph (mask 241276) represented by a 12-gate AND/OR circuit on the one-a-side promise |
| **[`L-meta-11141`](https://pequalnp.com/s/L-meta-11141)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_11141.lean`](proofs/lemmas/L_meta_11141.lean) | [PR #15180](https://github.com/open-goat/pequalnp-proofs/pull/15180) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-11141` |
| **[`L-meta-10311`](https://pequalnp.com/s/L-meta-10311)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10311.lean`](proofs/lemmas/L_meta_10311.lean) | [PR #14432](https://github.com/open-goat/pequalnp-proofs/pull/14432) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10311` |
| **[`L-meta-10307`](https://pequalnp.com/s/L-meta-10307)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10307.lean`](proofs/lemmas/L_meta_10307.lean) | [PR #14418](https://github.com/open-goat/pequalnp-proofs/pull/14418) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10307` |
| **[`L-meta-10303`](https://pequalnp.com/s/L-meta-10303)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10303.lean`](proofs/lemmas/L_meta_10303.lean) | [PR #14405](https://github.com/open-goat/pequalnp-proofs/pull/14405) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10303` |
| **[`L-meta-10301`](https://pequalnp.com/s/L-meta-10301)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10301.lean`](proofs/lemmas/L_meta_10301.lean) | [PR #14391](https://github.com/open-goat/pequalnp-proofs/pull/14391) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10301` |
| **[`L-meta-10241`](https://pequalnp.com/s/L-meta-10241)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10241.lean`](proofs/lemmas/L_meta_10241.lean) | [PR #14362](https://github.com/open-goat/pequalnp-proofs/pull/14362) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10241` |
| **[`L-meta-10237`](https://pequalnp.com/s/L-meta-10237)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10237.lean`](proofs/lemmas/L_meta_10237.lean) | [PR #14345](https://github.com/open-goat/pequalnp-proofs/pull/14345) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10237` |
| **[`L-meta-10233`](https://pequalnp.com/s/L-meta-10233)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10233.lean`](proofs/lemmas/L_meta_10233.lean) | [PR #14327](https://github.com/open-goat/pequalnp-proofs/pull/14327) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10233` |
| **[`L-meta-10229`](https://pequalnp.com/s/L-meta-10229)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10229.lean`](proofs/lemmas/L_meta_10229.lean) | [PR #14312](https://github.com/open-goat/pequalnp-proofs/pull/14312) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10229` |
| **[`L-meta-10227`](https://pequalnp.com/s/L-meta-10227)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10227.lean`](proofs/lemmas/L_meta_10227.lean) | [PR #14300](https://github.com/open-goat/pequalnp-proofs/pull/14300) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10227` |
| **[`L-meta-10225`](https://pequalnp.com/s/L-meta-10225)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10225.lean`](proofs/lemmas/L_meta_10225.lean) | [PR #14289](https://github.com/open-goat/pequalnp-proofs/pull/14289) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10225` |
| **[`L-meta-10275`](https://pequalnp.com/s/L-meta-10275)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10275.lean`](proofs/lemmas/L_meta_10275.lean) | [PR #14264](https://github.com/open-goat/pequalnp-proofs/pull/14264) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10275` |
| **[`L-meta-10271`](https://pequalnp.com/s/L-meta-10271)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10271.lean`](proofs/lemmas/L_meta_10271.lean) | [PR #14253](https://github.com/open-goat/pequalnp-proofs/pull/14253) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10271` |
| **[`L-meta-10269`](https://pequalnp.com/s/L-meta-10269)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10269.lean`](proofs/lemmas/L_meta_10269.lean) | [PR #14239](https://github.com/open-goat/pequalnp-proofs/pull/14239) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10269` |
| **[`L-meta-10383`](https://pequalnp.com/s/L-meta-10383)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10383.lean`](proofs/lemmas/L_meta_10383.lean) | [PR #14194](https://github.com/open-goat/pequalnp-proofs/pull/14194) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10383` |
| **[`L-meta-10385`](https://pequalnp.com/s/L-meta-10385)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10385.lean`](proofs/lemmas/L_meta_10385.lean) | [PR #14153](https://github.com/open-goat/pequalnp-proofs/pull/14153) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-10385` |
| **[`L-meta-9482`](https://pequalnp.com/s/L-meta-9482)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_9482.lean`](proofs/lemmas/L_meta_9482.lean) | [PR #13847](https://github.com/open-goat/pequalnp-proofs/pull/13847) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-9482` |
| **[`L-meta-7567`](https://pequalnp.com/s/L-meta-7567)** | Lemma (`L-*`) | **50** | 3 | [`proofs/lemmas/L_meta_7567.lean`](proofs/lemmas/L_meta_7567.lean) | [PR #13478](https://github.com/open-goat/pequalnp-proofs/pull/13478) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-7567` |
| **[`L-meta-4033`](https://pequalnp.com/s/L-meta-4033)** | Lemma (`L-*`) | **50** | 2 | [`proofs/lemmas/L_meta_4033.lean`](proofs/lemmas/L_meta_4033.lean) | [PR #13410](https://github.com/open-goat/pequalnp-proofs/pull/13410) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-4033` |
| **[`L-meta-8957`](https://pequalnp.com/s/L-meta-8957)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_8957.lean`](proofs/lemmas/L_meta_8957.lean) | [PR #13379](https://github.com/open-goat/pequalnp-proofs/pull/13379) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-8957` |
| **[`L-meta-8035`](https://pequalnp.com/s/L-meta-8035)** | Lemma (`L-*`) | **50** | 3 | [`proofs/lemmas/L_meta_8035.lean`](proofs/lemmas/L_meta_8035.lean) | [PR #13317](https://github.com/open-goat/pequalnp-proofs/pull/13317) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-8035` |
| **[`L-meta-7330`](https://pequalnp.com/s/L-meta-7330)** | Lemma (`L-*`) | **50** | 3 | [`proofs/lemmas/L_meta_7330.lean`](proofs/lemmas/L_meta_7330.lean) | [PR #13272](https://github.com/open-goat/pequalnp-proofs/pull/13272) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-7330` |
| **[`L-meta-8149`](https://pequalnp.com/s/L-meta-8149)** | Lemma (`L-*`) | **5** | 3 | [`proofs/lemmas/L_meta_8149.lean`](proofs/lemmas/L_meta_8149.lean) | [PR #13130](https://github.com/open-goat/pequalnp-proofs/pull/13130) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-8149` |
| **[`L-meta-7215`](https://pequalnp.com/s/L-meta-7215)** | Lemma (`L-*`) | **50** | 2 | [`proofs/lemmas/L_meta_7215.lean`](proofs/lemmas/L_meta_7215.lean) | [PR #12986](https://github.com/open-goat/pequalnp-proofs/pull/12986) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-7215` |
| **[`L-meta-8363`](https://pequalnp.com/s/L-meta-8363)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_8363.lean`](proofs/lemmas/L_meta_8363.lean) | [PR #12980](https://github.com/open-goat/pequalnp-proofs/pull/12980) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-8363` |
| **[`L-meta-8385`](https://pequalnp.com/s/L-meta-8385)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_8385.lean`](proofs/lemmas/L_meta_8385.lean) | [PR #12979](https://github.com/open-goat/pequalnp-proofs/pull/12979) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-8385` |
| **[`L-meta-8353`](https://pequalnp.com/s/L-meta-8353)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_8353.lean`](proofs/lemmas/L_meta_8353.lean) | [PR #12965](https://github.com/open-goat/pequalnp-proofs/pull/12965) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-8353` |
| **[`L-meta-7077`](https://pequalnp.com/s/L-meta-7077)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_7077.lean`](proofs/lemmas/L_meta_7077.lean) | [PR #12603](https://github.com/open-goat/pequalnp-proofs/pull/12603) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-7077` |
| **[`L-meta-5964`](https://pequalnp.com/s/L-meta-5964)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_5964.lean`](proofs/lemmas/L_meta_5964.lean) | [PR #12534](https://github.com/open-goat/pequalnp-proofs/pull/12534) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-5964` |
| **[`L-meta-6240`](https://pequalnp.com/s/L-meta-6240)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_6240.lean`](proofs/lemmas/L_meta_6240.lean) | [PR #12348](https://github.com/open-goat/pequalnp-proofs/pull/12348) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-6240` |
| **[`L-meta-6838`](https://pequalnp.com/s/L-meta-6838)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_6838.lean`](proofs/lemmas/L_meta_6838.lean) | [PR #12277](https://github.com/open-goat/pequalnp-proofs/pull/12277) | **MERGED** (`2026-11-25`) | Formal proof of `L-meta-6838` |
| **[`R-meta-2450-3`](https://pequalnp.com/s/L-meta-2450)** | Reduction (`R-*`) | **20** | 0 | [`proofs/reductions/R_meta_2450_3.lean`](proofs/reductions/R_meta_2450_3.lean) | [PR #12055](https://github.com/open-goat/pequalnp-proofs/pull/12055) | **MERGED** (`2026-11-25`) | Formal proof of `R-meta-2450-3` |
| **[`L-meta-11151`](https://pequalnp.com/s/L-meta-11151)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_11151.lean`](proofs/lemmas/L_meta_11151.lean) | [PR #15204](https://github.com/open-goat/pequalnp-proofs/pull/15204) | **CLOSED** (duplicate: another PR proved it first) | Formal proof of `L-meta-11151` |
| **[`L-meta-11149`](https://pequalnp.com/s/L-meta-11149)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_11149.lean`](proofs/lemmas/L_meta_11149.lean) | [PR #15194](https://github.com/open-goat/pequalnp-proofs/pull/15194) | **CLOSED** (duplicate: another PR proved it first) | Formal proof of `L-meta-11149` |
| **[`L-meta-11147`](https://pequalnp.com/s/L-meta-11147)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_11147.lean`](proofs/lemmas/L_meta_11147.lean) | [PR #15187](https://github.com/open-goat/pequalnp-proofs/pull/15187) | **CLOSED** (duplicate: another PR proved it first) | Formal proof of `L-meta-11147` |
| **[`L-meta-11117`](https://pequalnp.com/s/L-meta-11117)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_11117.lean`](proofs/lemmas/L_meta_11117.lean) | [PR #15176](https://github.com/open-goat/pequalnp-proofs/pull/15176) | **CLOSED** (duplicate: another PR proved it first) | Formal proof of `L-meta-11117` |
| **[`L-meta-11109`](https://pequalnp.com/s/L-meta-11109)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_11109.lean`](proofs/lemmas/L_meta_11109.lean) | [PR #15169](https://github.com/open-goat/pequalnp-proofs/pull/15169) | **CLOSED** (duplicate: another PR proved it first) | Formal proof of `L-meta-11109` |
| **[`L-meta-11107`](https://pequalnp.com/s/L-meta-11107)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_11107.lean`](proofs/lemmas/L_meta_11107.lean) | [PR #15162](https://github.com/open-goat/pequalnp-proofs/pull/15162) | **CLOSED** (duplicate: another PR proved it first) | Formal proof of `L-meta-11107` |
| **[`L-meta-10297`](https://pequalnp.com/s/L-meta-10297)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10297.lean`](proofs/lemmas/L_meta_10297.lean) | [PR #14382](https://github.com/open-goat/pequalnp-proofs/pull/14382) | **CLOSED** (duplicate: another PR proved it first) | Formal proof of `L-meta-10297` |
| **[`L-meta-10381`](https://pequalnp.com/s/L-meta-10381)** | Lemma (`L-*`) | **55** | 0 | [`proofs/lemmas/L_meta_10381.lean`](proofs/lemmas/L_meta_10381.lean) | [PR #14197](https://github.com/open-goat/pequalnp-proofs/pull/14197) | **CLOSED** (duplicate: another PR proved it first) | Formal proof of `L-meta-10381` |
| **[`L-meta-9488`](https://pequalnp.com/s/L-meta-9488)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_9488.lean`](proofs/lemmas/L_meta_9488.lean) | [PR #14034](https://github.com/open-goat/pequalnp-proofs/pull/14034) | **CLOSED** (duplicate: another PR proved it first) | Formal proof of `L-meta-9488` |
| **[`L-meta-8133`](https://pequalnp.com/s/L-meta-8133)** | Lemma (`L-*`) | **50** | 4 | [`proofs/lemmas/L_meta_8133.lean`](proofs/lemmas/L_meta_8133.lean) | [PR #13518](https://github.com/open-goat/pequalnp-proofs/pull/13518) | **CLOSED** (refused: file over 512 KiB) | Formal proof of `L-meta-8133` |
| **[`L-meta-7879`](https://pequalnp.com/s/L-meta-7879)** | Lemma (`L-*`) | **50** | 3 | [`proofs/lemmas/L_meta_7879.lean`](proofs/lemmas/L_meta_7879.lean) | [PR #13323](https://github.com/open-goat/pequalnp-proofs/pull/13323) | **CLOSED** (step withdrawn by the desk) | Formal proof of `L-meta-7879` |
| **[`L-meta-7877`](https://pequalnp.com/s/L-meta-7877)** | Lemma (`L-*`) | **50** | 3 | [`proofs/lemmas/L_meta_7877.lean`](proofs/lemmas/L_meta_7877.lean) | [PR #13318](https://github.com/open-goat/pequalnp-proofs/pull/13318) | **CLOSED** (step withdrawn by the desk) | Formal proof of `L-meta-7877` |
| **[`L-meta-7794`](https://pequalnp.com/s/L-meta-7794)** | Lemma (`L-*`) | **50** | 3 | [`proofs/lemmas/L_meta_7794.lean`](proofs/lemmas/L_meta_7794.lean) | [PR #13294](https://github.com/open-goat/pequalnp-proofs/pull/13294) | **CLOSED** (check timed out at 20 min, twice) | Formal proof of `L-meta-7794` |
| **[`L-meta-6754`](https://pequalnp.com/s/L-meta-6754)** | Lemma (`L-*`) | **50** | 3 | [`proofs/lemmas/L_meta_6754.lean`](proofs/lemmas/L_meta_6754.lean) | [PR #13286](https://github.com/open-goat/pequalnp-proofs/pull/13286) | **RE-LEASED** (old proof timed out; being redone) | Formal proof of `L-meta-6754` |
| **[`L-meta-7124`](https://pequalnp.com/s/L-meta-7124)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_7124.lean`](proofs/lemmas/L_meta_7124.lean) | [PR #12746](https://github.com/open-goat/pequalnp-proofs/pull/12746) | **CLOSED** (refused: disallowed import) | Formal proof of `L-meta-7124` |
| **[`L-meta-5950`](https://pequalnp.com/s/L-meta-5950)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_5950.lean`](proofs/lemmas/L_meta_5950.lean) | [PR #12386](https://github.com/open-goat/pequalnp-proofs/pull/12386) | **CLOSED** (step withdrawn by the desk) | Formal proof of `L-meta-5950` |
| **[`L-meta-7551`](https://pequalnp.com/s/L-meta-7551)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_7551.lean`](proofs/lemmas/L_meta_7551.lean) | [PR #12206](https://github.com/open-goat/pequalnp-proofs/pull/12206) | **CLOSED** (duplicate: another PR proved it first) | Formal proof of `L-meta-7551` |
| **[`L-meta-7608`](https://pequalnp.com/s/L-meta-7608)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_7608.lean`](proofs/lemmas/L_meta_7608.lean) | [PR #12194](https://github.com/open-goat/pequalnp-proofs/pull/12194) | **CLOSED** (duplicate: another PR proved it first) | Formal proof of `L-meta-7608` |
| **[`L-meta-7606`](https://pequalnp.com/s/L-meta-7606)** | Lemma (`L-*`) | **50** | 0 | [`proofs/lemmas/L_meta_7606.lean`](proofs/lemmas/L_meta_7606.lean) | [PR #12189](https://github.com/open-goat/pequalnp-proofs/pull/12189) | **CLOSED** (duplicate: another PR proved it first) | Formal proof of `L-meta-7606` |
---

## In Review

On 2026-11-26 I sent 320 PRs for two families of small circuit steps:
- **Two-lit functions:** a circuit that must be right at every input with one or two points lit, found by exact SAT.
- **Graph representations:** a circuit that must be right at every input with one left and one right vertex on, built by the star construction or found by SAT.

These steps allow several contributors to work on the same step at once, and the first PR to pass the checker wins. 270 of mine closed because another contributor's PR merged first. Every one of those was a correct proof that lost its race. The other 50 are still open, but other contributors have already proved almost all of those steps, so they are expected to close the same way.

Lesson: for steps posted in batches, check for open and merged PRs on the step before sending, and only send when you can be first.

<details><summary>50 still-open pull requests</summary>

| Step | File | PR |
| :--- | :--- | :--- |
| [`L-meta-22575`](https://pequalnp.com/s/L-meta-22575) | [`proofs/pending/L_meta_22575.lean`](proofs/pending/L_meta_22575.lean) | [#35422](https://github.com/open-goat/pequalnp-proofs/pull/35422) |
| [`L-meta-22573`](https://pequalnp.com/s/L-meta-22573) | [`proofs/pending/L_meta_22573.lean`](proofs/pending/L_meta_22573.lean) | [#35423](https://github.com/open-goat/pequalnp-proofs/pull/35423) |
| [`L-meta-22576`](https://pequalnp.com/s/L-meta-22576) | [`proofs/pending/L_meta_22576.lean`](proofs/pending/L_meta_22576.lean) | [#35450](https://github.com/open-goat/pequalnp-proofs/pull/35450) |
| [`L-meta-22585`](https://pequalnp.com/s/L-meta-22585) | [`proofs/pending/L_meta_22585.lean`](proofs/pending/L_meta_22585.lean) | [#35483](https://github.com/open-goat/pequalnp-proofs/pull/35483) |
| [`L-meta-22571`](https://pequalnp.com/s/L-meta-22571) | [`proofs/pending/L_meta_22571.lean`](proofs/pending/L_meta_22571.lean) | [#35486](https://github.com/open-goat/pequalnp-proofs/pull/35486) |
| [`L-meta-22558`](https://pequalnp.com/s/L-meta-22558) | [`proofs/pending/L_meta_22558.lean`](proofs/pending/L_meta_22558.lean) | [#35492](https://github.com/open-goat/pequalnp-proofs/pull/35492) |
| [`L-meta-22579`](https://pequalnp.com/s/L-meta-22579) | [`proofs/pending/L_meta_22579.lean`](proofs/pending/L_meta_22579.lean) | [#35525](https://github.com/open-goat/pequalnp-proofs/pull/35525) |
| [`L-meta-22578`](https://pequalnp.com/s/L-meta-22578) | [`proofs/pending/L_meta_22578.lean`](proofs/pending/L_meta_22578.lean) | [#35526](https://github.com/open-goat/pequalnp-proofs/pull/35526) |
| [`L-meta-22584`](https://pequalnp.com/s/L-meta-22584) | [`proofs/pending/L_meta_22584.lean`](proofs/pending/L_meta_22584.lean) | [#35547](https://github.com/open-goat/pequalnp-proofs/pull/35547) |
| [`L-meta-22622`](https://pequalnp.com/s/L-meta-22622) | [`proofs/pending/L_meta_22622.lean`](proofs/pending/L_meta_22622.lean) | [#35561](https://github.com/open-goat/pequalnp-proofs/pull/35561) |
| [`L-meta-22550`](https://pequalnp.com/s/L-meta-22550) | [`proofs/pending/L_meta_22550.lean`](proofs/pending/L_meta_22550.lean) | [#35562](https://github.com/open-goat/pequalnp-proofs/pull/35562) |
| [`L-meta-22590`](https://pequalnp.com/s/L-meta-22590) | [`proofs/pending/L_meta_22590.lean`](proofs/pending/L_meta_22590.lean) | [#35563](https://github.com/open-goat/pequalnp-proofs/pull/35563) |
| [`L-meta-22553`](https://pequalnp.com/s/L-meta-22553) | [`proofs/pending/L_meta_22553.lean`](proofs/pending/L_meta_22553.lean) | [#35579](https://github.com/open-goat/pequalnp-proofs/pull/35579) |
| [`L-meta-22580`](https://pequalnp.com/s/L-meta-22580) | [`proofs/pending/L_meta_22580.lean`](proofs/pending/L_meta_22580.lean) | [#35608](https://github.com/open-goat/pequalnp-proofs/pull/35608) |
| [`L-meta-22496`](https://pequalnp.com/s/L-meta-22496) | [`proofs/pending/L_meta_22496.lean`](proofs/pending/L_meta_22496.lean) | [#35609](https://github.com/open-goat/pequalnp-proofs/pull/35609) |
| [`L-meta-22588`](https://pequalnp.com/s/L-meta-22588) | [`proofs/pending/L_meta_22588.lean`](proofs/pending/L_meta_22588.lean) | [#35714](https://github.com/open-goat/pequalnp-proofs/pull/35714) |
| [`L-meta-22480`](https://pequalnp.com/s/L-meta-22480) | [`proofs/pending/L_meta_22480.lean`](proofs/pending/L_meta_22480.lean) | [#35730](https://github.com/open-goat/pequalnp-proofs/pull/35730) |
| [`L-meta-22521`](https://pequalnp.com/s/L-meta-22521) | [`proofs/pending/L_meta_22521.lean`](proofs/pending/L_meta_22521.lean) | [#35732](https://github.com/open-goat/pequalnp-proofs/pull/35732) |
| [`L-meta-22490`](https://pequalnp.com/s/L-meta-22490) | [`proofs/pending/L_meta_22490.lean`](proofs/pending/L_meta_22490.lean) | [#35770](https://github.com/open-goat/pequalnp-proofs/pull/35770) |
| [`L-meta-22479`](https://pequalnp.com/s/L-meta-22479) | [`proofs/pending/L_meta_22479.lean`](proofs/pending/L_meta_22479.lean) | [#35789](https://github.com/open-goat/pequalnp-proofs/pull/35789) |
| [`L-meta-23578`](https://pequalnp.com/s/L-meta-23578) | [`proofs/pending/L_meta_23578.lean`](proofs/pending/L_meta_23578.lean) | [#35791](https://github.com/open-goat/pequalnp-proofs/pull/35791) |
| [`L-meta-22499`](https://pequalnp.com/s/L-meta-22499) | [`proofs/pending/L_meta_22499.lean`](proofs/pending/L_meta_22499.lean) | [#35796](https://github.com/open-goat/pequalnp-proofs/pull/35796) |
| [`L-meta-22308`](https://pequalnp.com/s/L-meta-22308) | [`proofs/pending/L_meta_22308.lean`](proofs/pending/L_meta_22308.lean) | [#35801](https://github.com/open-goat/pequalnp-proofs/pull/35801) |
| [`L-meta-22535`](https://pequalnp.com/s/L-meta-22535) | [`proofs/pending/L_meta_22535.lean`](proofs/pending/L_meta_22535.lean) | [#35832](https://github.com/open-goat/pequalnp-proofs/pull/35832) |
| [`L-meta-23638`](https://pequalnp.com/s/L-meta-23638) | [`proofs/pending/L_meta_23638.lean`](proofs/pending/L_meta_23638.lean) | [#35840](https://github.com/open-goat/pequalnp-proofs/pull/35840) |
| [`L-meta-22484`](https://pequalnp.com/s/L-meta-22484) | [`proofs/pending/L_meta_22484.lean`](proofs/pending/L_meta_22484.lean) | [#35880](https://github.com/open-goat/pequalnp-proofs/pull/35880) |
| [`L-meta-22276`](https://pequalnp.com/s/L-meta-22276) | [`proofs/pending/L_meta_22276.lean`](proofs/pending/L_meta_22276.lean) | [#35889](https://github.com/open-goat/pequalnp-proofs/pull/35889) |
| [`L-meta-22101`](https://pequalnp.com/s/L-meta-22101) | [`proofs/pending/L_meta_22101.lean`](proofs/pending/L_meta_22101.lean) | [#35904](https://github.com/open-goat/pequalnp-proofs/pull/35904) |
| [`L-meta-22483`](https://pequalnp.com/s/L-meta-22483) | [`proofs/pending/L_meta_22483.lean`](proofs/pending/L_meta_22483.lean) | [#35907](https://github.com/open-goat/pequalnp-proofs/pull/35907) |
| [`L-meta-23686`](https://pequalnp.com/s/L-meta-23686) | [`proofs/pending/L_meta_23686.lean`](proofs/pending/L_meta_23686.lean) | [#35912](https://github.com/open-goat/pequalnp-proofs/pull/35912) |
| [`L-meta-22583`](https://pequalnp.com/s/L-meta-22583) | [`proofs/pending/L_meta_22583.lean`](proofs/pending/L_meta_22583.lean) | [#35930](https://github.com/open-goat/pequalnp-proofs/pull/35930) |
| [`L-meta-22599`](https://pequalnp.com/s/L-meta-22599) | [`proofs/pending/L_meta_22599.lean`](proofs/pending/L_meta_22599.lean) | [#35963](https://github.com/open-goat/pequalnp-proofs/pull/35963) |
| [`L-meta-23640`](https://pequalnp.com/s/L-meta-23640) | [`proofs/pending/L_meta_23640.lean`](proofs/pending/L_meta_23640.lean) | [#35972](https://github.com/open-goat/pequalnp-proofs/pull/35972) |
| [`L-meta-23685`](https://pequalnp.com/s/L-meta-23685) | [`proofs/pending/L_meta_23685.lean`](proofs/pending/L_meta_23685.lean) | [#35991](https://github.com/open-goat/pequalnp-proofs/pull/35991) |
| [`L-meta-22069`](https://pequalnp.com/s/L-meta-22069) | [`proofs/pending/L_meta_22069.lean`](proofs/pending/L_meta_22069.lean) | [#36046](https://github.com/open-goat/pequalnp-proofs/pull/36046) |
| [`L-meta-22491`](https://pequalnp.com/s/L-meta-22491) | [`proofs/pending/L_meta_22491.lean`](proofs/pending/L_meta_22491.lean) | [#36057](https://github.com/open-goat/pequalnp-proofs/pull/36057) |
| [`L-meta-22309`](https://pequalnp.com/s/L-meta-22309) | [`proofs/pending/L_meta_22309.lean`](proofs/pending/L_meta_22309.lean) | [#36087](https://github.com/open-goat/pequalnp-proofs/pull/36087) |
| [`L-meta-22342`](https://pequalnp.com/s/L-meta-22342) | [`proofs/pending/L_meta_22342.lean`](proofs/pending/L_meta_22342.lean) | [#36099](https://github.com/open-goat/pequalnp-proofs/pull/36099) |
| [`L-meta-22017`](https://pequalnp.com/s/L-meta-22017) | [`proofs/pending/L_meta_22017.lean`](proofs/pending/L_meta_22017.lean) | [#36177](https://github.com/open-goat/pequalnp-proofs/pull/36177) |
| [`L-meta-22531`](https://pequalnp.com/s/L-meta-22531) | [`proofs/pending/L_meta_22531.lean`](proofs/pending/L_meta_22531.lean) | [#36228](https://github.com/open-goat/pequalnp-proofs/pull/36228) |
| [`L-meta-23852`](https://pequalnp.com/s/L-meta-23852) | [`proofs/pending/L_meta_23852.lean`](proofs/pending/L_meta_23852.lean) | [#36354](https://github.com/open-goat/pequalnp-proofs/pull/36354) |
| [`L-meta-22265`](https://pequalnp.com/s/L-meta-22265) | [`proofs/pending/L_meta_22265.lean`](proofs/pending/L_meta_22265.lean) | [#36445](https://github.com/open-goat/pequalnp-proofs/pull/36445) |
| [`L-meta-22242`](https://pequalnp.com/s/L-meta-22242) | [`proofs/pending/L_meta_22242.lean`](proofs/pending/L_meta_22242.lean) | [#36454](https://github.com/open-goat/pequalnp-proofs/pull/36454) |
| [`L-meta-22268`](https://pequalnp.com/s/L-meta-22268) | [`proofs/pending/L_meta_22268.lean`](proofs/pending/L_meta_22268.lean) | [#36455](https://github.com/open-goat/pequalnp-proofs/pull/36455) |
| [`L-meta-22220`](https://pequalnp.com/s/L-meta-22220) | [`proofs/pending/L_meta_22220.lean`](proofs/pending/L_meta_22220.lean) | [#36467](https://github.com/open-goat/pequalnp-proofs/pull/36467) |
| [`L-meta-22201`](https://pequalnp.com/s/L-meta-22201) | [`proofs/pending/L_meta_22201.lean`](proofs/pending/L_meta_22201.lean) | [#36473](https://github.com/open-goat/pequalnp-proofs/pull/36473) |
| [`L-meta-22264`](https://pequalnp.com/s/L-meta-22264) | [`proofs/pending/L_meta_22264.lean`](proofs/pending/L_meta_22264.lean) | [#36476](https://github.com/open-goat/pequalnp-proofs/pull/36476) |
| [`L-meta-22215`](https://pequalnp.com/s/L-meta-22215) | [`proofs/pending/L_meta_22215.lean`](proofs/pending/L_meta_22215.lean) | [#36484](https://github.com/open-goat/pequalnp-proofs/pull/36484) |
| [`L-meta-22217`](https://pequalnp.com/s/L-meta-22217) | [`proofs/pending/L_meta_22217.lean`](proofs/pending/L_meta_22217.lean) | [#36518](https://github.com/open-goat/pequalnp-proofs/pull/36518) |
| [`L-meta-24972`](https://pequalnp.com/s/L-meta-24972) | [`proofs/pending/L_meta_24972.lean`](proofs/pending/L_meta_24972.lean) | [#36889](https://github.com/open-goat/pequalnp-proofs/pull/36889) |

</details>

---

## Detailed Breakdown of Proofs & Where They Fit in the Global Attack

### 1. Monotone Set-Circuit Normalization & Frontier Replay (`L-meta-5070` Branch)
In the meta-complexity / circuit lower-bound Spine under [`L-meta-5070`](https://pequalnp.com/s/L-meta-5070), reductions [`R_meta_5070_639.lean`](https://github.com/open-goat/pequalnp-proofs/blob/main/lean/PEqualNP/Outside/R_meta_5070_639.lean) and [`R_meta_5070_623.lean`](https://github.com/open-goat/pequalnp-proofs/blob/main/lean/PEqualNP/Outside/R_meta_5070_623.lean) decompose multi-output truth-table circuit bounds into structural properties of set-algebraic traces (`∪` and `∩` operations over wire sets):

- **[`L-meta-7606`](proofs/lemmas/L_meta_7606.lean) ([PR #12189](https://github.com/open-goat/pequalnp-proofs/pull/12189), Weight 100, Depth 5)** — *Normalized Irredundant Sub-Trace Extraction (`normalize`)*:
  - **Statement**: Given an `m`-input, `s`-gate set-circuit $W : \mathbb{N} \to \text{Set } \alpha$ where each gate $W(m+k) \in \{W(a) \cup W(b),\, W(a),\, \emptyset,\, W(a) \cap W(b)\}$ for $\max(a,b) < m+k$, any non-empty wire $W(o) \neq \emptyset$ ($o < m+s$) lies in the image of an extracted irredundant sub-list $T \subseteq [m, m+s)$ of length $\le s$ where every step combines two incomparable prior non-empty sets ($\neg A \subseteq B \land \neg B \subseteq A$) via $\cup$ or $\cap$.
  - **Proof Method**: Strong induction on the circuit size $s$. At step $s \to s+1$, if $W(m+s)$ is non-empty and not already present in the normalized pool $\text{map } W (\text{range } m \mathbin{++} T)$, we show neither operand $W(a), W(b)$ can be empty or comparable (otherwise $W(m+s)$ would collapse to one of them and already reside in the pool), allowing $m+s$ to be appended cleanly.

- **[`L-meta-7608`](proofs/lemmas/L_meta_7608.lean) ([PR #12194](https://github.com/open-goat/pequalnp-proofs/pull/12194), Weight 100, Depth 5)** — *Pointwise Frontier Intersection Witness (`frontier`)*:
  - **Statement**: Given source sets $\text{src}$, a trace $T$ of $\cup/\cap$ gates over $\text{src} \mathbin{++} T$, and a target set $\text{out} \in \text{src} \mathbin{++} T$ such that no $A \in \text{src}$ satisfies $A \subseteq \text{out}$, every element $x \in \text{out}$ is covered by an intersection gate $T[i] = A \cap B \subseteq \text{out}$ with $x \in T[i]$ whose operands both cross the boundary of $\text{out}$ ($\neg A \subseteq \text{out}$ and $\neg B \subseteq \text{out}$).
  - **Proof Method**: Strong induction (`Nat.strong_induction_on`) over the gate index $k < |T|$ for which $T[k] \subseteq \text{out}$ and $x \in T[k]$. Union gates pass the subset and membership invariants directly to whichever operand contains $x$; intersection gates either recurse into an operand already contained in $\text{out}$ or terminate immediately as the desired frontier witness.

- **[`L-meta-7551`](proofs/lemmas/L_meta_7551.lean) ([PR #12206](https://github.com/open-goat/pequalnp-proofs/pull/12206), Weight 60, Depth 3)** — *Truth-Table Padding Invariance (`pad_invariance`)*:
  - **Statement**: For any fan-in-two Boolean circuit $C$ on 15 primary inputs (`Fin 32768`) padded with an arbitrary tail `pad : List Bool`, if every gate index $i < |C.\text{gates}|$ has fan-in wire indices strictly below $15 + i$, then every wire value at index $< 15 + |C.\text{gates}|$ (and in particular $C.\text{eval}$) is independent of `pad`.
  - **Proof Method**: Structural induction on a prefix of the gate list via `List.foldl` invariant lemmas (`wires_take`, `wires_getElem`), proving that at step $k$, gate $k$ only reads wire indices $< 15 + k$, which lie strictly within the prefix of length $15 + k$ where the padded and unpadded wire arrays agree.

---

### 2. TopForm & Edge-Ownership Lower Bounds on 4-Cycle-Free Graphs (`L-meta-1340` Branch)
Under [`L-meta-1340`](https://pequalnp.com/s/L-meta-1340) (*Minimum And/Or Circuit Complexity of 4-Cycle-Free Graph Edge Functions*), a least-size fan-in-2 monotone circuit (`IsLeastAO G C`) computing the edge predicate `graphFun G ∅` of a $C_4$-free graph $G$ is analyzed via its top-level AND gates (`tops G C`), "junk" AND gates (`junk G C` — AND gates that fire on at least one non-edge input), and unhandled edges (`Ustar G C`):

- **[`R-meta-2450-3`](proofs/reductions/R_meta_2450_3.lean) ([PR #12055](https://github.com/open-goat/pequalnp-proofs/pull/12055) — MERGED, Weight 20, Depth 1)**:
  - **Role**: Reduces [`L-meta-2450`](https://pequalnp.com/s/L-meta-2450) (the clean double-junk case `junk G C = {j, k}` with `CleanedNonEdge G C j` and `CleanedNonEdge G C k`) into two independent lemmas:
    1. `analyze`: Structural inclusion `Ustar G C ⊆ gammaE G C j ∩ gammaE G C k` plus the star-edge biclique cover of size $\le |\text{tops } G\ C \setminus \text{centreless } G\ C|$.
    2. `cover_bound`: The finite-set counting deduction combining the star cover, `CleanedNonEdge` vertex-cover bounds of size $\le 2$ on `gammaE`, and `lamAvoidsUstar` to establish `HasSharedBlockCost G (C.gates.length + 1)`.

- **[`L-meta-6838`](proofs/lemmas/L_meta_6838.lean) ([PR #12277](https://github.com/open-goat/pequalnp-proofs/pull/12277), Weight 50, Depth 4)** — *Cleaned Non-Edge Bound (`cleaned_nonedge` in `R_meta_2572_7.lean`)*:
  - **Statement**: In any 4-cycle-free graph $G$ and least-AO circuit $C$ in `TopForm G C`, every junk gate $j \in \text{junk } G\ C$ satisfies `CleanedNonEdge G C j`: either all edges in $\gamma_E(G, C, j)$ are incident to a single vertex, or $\gamma_E(G, C, j)$ is covered by at most 2 vertices.
  - **Proof Method**: Combines the 4-cycle-free biclique star theorem (`L2695`) with OR-cone reachability (`Local1490`), analyzing whether the two operands of $j$ reach below-function gates or pure variable sets `orIn`, and bounding the resulting edge support via $C_4$-freeness.

- **[`L-meta-5964`](proofs/lemmas/L_meta_5964.lean) ([PR #12534](https://github.com/open-goat/pequalnp-proofs/pull/12534), Weight 50, Depth 2)** — *Symmetric Double-Junk Empty `Ustar` Analysis (`analyze` in `R_meta_2549_1.lean`)*:
  - **Statement**: When `junk G C = {j, k}` ($j \neq k$) and neither $j$ nor $k$ has a diagonal false pair on both operands ($\forall b, \neg \exists u, \text{pairInput } u\ u$ fires operand $b$), then `Ustar G C = ∅` and `lam G C` is disjoint from `Ustar G C`.
  - **Proof Method**: Traces any hypothetical edge $e = s(u,v) \in \text{Ustar } G\ C$ to an accepting top AND gate $a \in \text{centreless } G\ C$. Because $a$ is centreless and has no diagonal false operand on the junk gates, both operands of $a$ cannot simultaneously avoid $\{u,v\}$ in `orIn`, contradicting `e ∈ Ustar G C`.

- **[`L-meta-6240`](proofs/lemmas/L_meta_6240.lean) ([PR #12348](https://github.com/open-goat/pequalnp-proofs/pull/12348), Weight 25, Depth 2)** — *Asymmetric Double-Junk `Ustar` Inclusion (`analyze` in `R_meta_2549_8.lean`)*:
  - **Statement**: When `junk G C = {j, k}` ($j \neq k$), every $m \in \text{lam } G\ C$ has $\gamma_E(G, C, m)$ disjoint from `Ustar G C`, the star-handled edges `G.edgeFinset \ Ustar G C` are covered by at most $|\text{tops } G\ C \setminus \text{centreless } G\ C|$ star vertices, and under the asymmetric diagonal-false hypothesis on $j$, `Ustar G C ⊆ gammaE G C j ∩ gammaE G C k`.

- **[`L-meta-7077`](proofs/lemmas/L_meta_7077.lean) ([PR #12603](https://github.com/open-goat/pequalnp-proofs/pull/12603), Weight 25, Depth 2)** — *Zero/Single-Junk `Ustar` Cover Analysis (`analyze` in `R_meta_4185_7.lean`)*:
  - **Statement**: Establishes the three core structural claims for [`L-meta-4185`](https://pequalnp.com/s/L-meta-4185):
    1. `starEdges G C` admits a vertex cover of cardinality $\le |\text{tops } G\ C \setminus \text{centreless } G\ C|$;
    2. If `junk G C = ∅`, then `Ustar G C = ∅`;
    3. If `junk G C = {g}` and $g$ has a diagonal-false operand ($\text{opnd } C\ g\ b$ fires on $\text{pairInput } u\ u$), then `Ustar G C` admits a vertex cover of cardinality $\le 2$.

- **[`L-meta-5950`](proofs/lemmas/L_meta_5950.lean) ([PR #12386](https://github.com/open-goat/pequalnp-proofs/pull/12386), Weight 25, Depth 3)** — *Shared-Block-Cost Combinatorial Deduction (`cover_bound` in `R_meta_2687_1.lean`)*:
  - **Statement**: Proves that when `Ustar G C ⊆ gammaE G C j ∩ gammaE G C k`, `starEdges G C` is covered by $S$ with $|S| \le |\text{tops } \setminus \text{centreless}|$, and $\gamma_E(j)$ is covered by $C_j$ with $|C_j| \le 2$, the union cover $S \cup C_j$ plus `lam G C` witnesses `HasSharedBlockCost G (C.gates.length + 1)`.

---

## Submission Workflow (lessons from the closed PRs)

1. **Only prove steps you hold a lease for.** Take each step with `tools/pnp.sh next` and renew it with `tools/pnp.sh beat <step>` every 5 minutes. A PR sent without a lease races the rest of the fleet. That is how 12 PRs above were closed as duplicates.
2. **Stay under the 20-minute check limit.** Time every file locally with `lake env lean` before `submit`, and aim for under about 10 minutes because CI runners are slower. If a proof needs more, send a reduction (`R_<prog>_<n>_<k>.lean`) that splits the heavy certificate into 2–4 smaller steps instead of one huge `decide` file.
3. **Keep files under 512 KiB**, import only `Mathlib` plus the modules the step lists, and use `tools/pnp.sh submit` so the lease is renewed right before the PR opens.

4. **For batch-posted steps, being first is what counts.** Families of small circuit steps get posted in batches and are taken within minutes. The fast route is to watch the public data at `data.pequalnp.com`, solve each new step straight away, then lease it with `tools/pnp.sh next --proof-of <step>`, check it and submit it, with several checkouts working in parallel.

## Verifying Proofs Locally

To verify any proof file against the upstream kernel guard (`check-lean.mjs`):

```bash
# Inside a clone of open-goat/pequalnp-proofs:
cp /path/to/PEqualNP/proofs/lemmas/L_meta_<ID>.lean lean/PEqualNP/Outside/L_meta_<ID>.lean
curl -s https://pequalnp.com/api/steps/L-meta-<ID> | jq -r '.statement' > /tmp/statement.txt
node tools/check-lean.mjs lean/PEqualNP/Outside/L_meta_<ID>.lean /tmp/statement.txt check
```
