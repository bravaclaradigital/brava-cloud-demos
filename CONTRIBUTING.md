# Contributing to Brava Cloud Demos

## Adding a New Demo

Each demo lives in its own top-level folder. To add one:

1. Create a folder: `<cloud>-<pattern>-<tool>/` (e.g. `gcp-gke-tf/`)
2. Add these files:
   - `main.tf` / `main.bicep`: root orchestration
   - `variables.tf` + `outputs.tf` (Terraform) or `parameters.bicepparam` (Bicep)
   - `modules/`: at least one reusable module
   - `README.md`: follow the template below
   - `backend.hcl.example` (Terraform only)
3. Add a GitHub Actions workflow to `.github/workflows/deploy-<demo-name>.yml`
4. Add a job to `.github/workflows/drift-detection.yml`
5. Add a row to the cost table in the root `README.md`

### README Template

Each demo README must include:

- **Prerequisites**: tools, versions, required secrets
- **What This Demo Deploys**: bulleted list
- **Architecture**: Mermaid diagram
- **Modules**: table of module name and purpose
- **Cost Estimate**: hourly + monthly table with destroy reminder
- **Key Outputs**: table and expected terminal output snippet
- **Security Note**: call out any intentionally permissive demo settings

### Workflow Template

Copy an existing workflow and update:
- `working-directory` to point at your new folder
- Cloud credentials (AWS or Azure)
- Backend config secrets

For Terraform demos, add `-backend-config` flags for all account-specific values.
Do not hardcode account IDs, storage account names, or subscription IDs in any tracked file.

## Updating an Existing Demo

- Keep changes backward-compatible where possible
- If you change variable names or module interfaces, update `terraform.tfvars.example`
- Update the cost table in root `README.md` if costs change
- Run `terraform fmt -recursive` before committing Terraform changes
- Run `az bicep lint` before committing Bicep changes

## Security Rules

- No secrets, account IDs, or credentials in any committed file
- Backend config files (`backend.hcl`) are gitignored; provide `.example` versions only
- Open security rules (0.0.0.0/0) are permitted in demo modules but must be documented
  with a `# DEMO NOTE` comment and a **Security Note** section in the README
- State files (`*.tfstate`) are gitignored; use remote backends only

## Questions

Open an issue or reach out to the Brava IT team.
