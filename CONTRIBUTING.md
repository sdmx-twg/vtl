# 🤝 Contributing Guidelines

Thank you for your interest in contributing to the **VTL** project!  
We’re excited to collaborate with the community to improve the Validation and Transformation Language.

To keep the repository clean and consistent, we follow a simple Git branching strategy and contribution process.

---

## 📌 Branching Model

- `master` is the **main branch** used for stable releases and GitHub Pages deployment.
- `develop` is the **default development branch**.  
  👉 All pull requests **must target `develop`**.

---

## 🧩 How to Contribute

1. **Create a feature or fix branch** from `develop`:
    - For features: `feat/short-description`
    - For bugfixes: `fix/short-description`

   **Example:**
   ```bash
   git checkout develop
   git checkout -b feat/add-new-operator
   ```

2. **Open an issue first**, if one doesn’t already exist.  
   Every pull request **must be linked to an existing issue** (use `Closes #issue-number` in the PR description).

3. **Write clear and concise commit messages.**

4. **Submit your pull request**, targeting `develop`.  
   Make sure your changes are well-tested and documented if applicable.

---

## ✉️ Maintainers & Permissions

- Contributors who are **actively involved** in the project can request **maintainer status** in order to work directly via branches in the main repository.  
  ➡️ To request access, please contact us at **angelo.linardi@bancaditalia.it** and **Attilio.Mattiocco@bancaditalia.it**.

- All other contributors are welcome to work through the standard **fork → branch → PR** workflow.

---

## 💬 Issues & Discussions

- Got a question, feature idea, or bug to report?  
  👉 **Open an [issue](../../issues)** or start a [discussion](../../discussions)!

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