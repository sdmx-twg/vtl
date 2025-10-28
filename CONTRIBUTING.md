# 🤝 Contributing Guidelines

Thank you for your interest in contributing to the **VTL** project!  
We’re excited to collaborate with the community to improve the Validation and Transformation Language.

To keep the repository clean and consistent, we follow a simple Git branching strategy and contribution process.

---
## 📌 Branching Model and Release Model

- **`master`** is the **main branch** — used for stable releases and GitHub Pages deployment.
- **`develop`** is the **default development branch**.  
  👉 All pull requests should **target `develop`**.

### 🔄 When `develop` is Merged into `master`

- We merge `develop` into `master` **only for releases** or important milestones.
- This usually means the code is **stable, tested, and ready to go live**.
- After merging, we:
    - **Tag the release** (e.g., `v1.2.0`)
    - Optionally write a short **release note or changelog**

### 👥 Who Does the Merge

- The **project maintainer** (or whoever handles releases) does the merge from `develop` to `master`.
- Before merging, we make sure:
    - All tests pass
    - Docs are updated
    - The release feels solid and ready

---

## 🧩 How to Contribute

1. **Open an issue first**, if one doesn’t already exist.  
Every pull request **must be linked to an existing issue** where the relevant discussion takes place — this helps keep all context in one place.  
Use `Related #issue-number` in the PR description instead of `Closes #issue-number`, since issues should be **closed explicitly** with a final comment summarizing the outcome (e.g., implementation completed or issue closed due to lack of consensus).

2. **Create a feature or fix branch** from `develop`:
    - For features: `feat/short-description`
    - For bugfixes: `fix/short-description`

   **Example:**
   ```bash
   git checkout develop
   git checkout -b feat/add-new-operator
   git commit -a -m "Adding the new integral operator"
   git push origin feat/add-new-operator
   ```

3. **Write clear and concise commit messages.**

4. **Submit your pull request**, targeting `develop`.  
   Make sure your changes are well-tested and documented if applicable.

---

## ✉️ Maintainers & Permissions

- Contributors who are **actively involved** in the project can request **maintainer status** to work directly via branches in the main repository.  
  ➡️ To request access, please contact **angelo.linardi@bancaditalia.it** and **Attilio.Mattiocco@bancaditalia.it**.

- All other contributors are welcome to work through the standard **fork → branch → PR** workflow.

- Maintainers should also follow the rules described in the [📌 Branching Model and Release Model](#-branching-model-and-release-model) section when working with `develop` and `master` branches.

---

## 💬 Issues & Discussions

- Got a question, feature idea, or bug to report?  
  👉 **Open an [issue](../../issues)**

- Issues are **prioritized by the VTL leads** from **Banca d’Italia**:
    - 👤 Angelo Linardi
    - 👤 Attilio Mattiocco

They review new issues and assign labels and priorities to help guide the development process.

---

## ✅ Code Review & Approval

Pull Requests are reviewed by the **core organizations**:

- **Banca d’Italia**
- **MeaningfulData**
- **Making Sense**

🔐 **Approval Rule**:  
A PR must receive **at least 2 approved reviews** from **2 different core organizations** before it can be merged.

- Minor changes (e.g., typos or comments) may be fast-tracked with a single approval, at the discretion of the core team.
- Changes to core logic, specifications, or language definitions may also require final confirmation from **Banca d’Italia**, as the delegated VTL authority.

---

Thanks again for contributing! 🙌  
Your input makes VTL stronger and more useful for everyone.