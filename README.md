# 🚀 n8n-HuggingFace Workflows

This repository provides guidance and resources to **host n8n on Hugging Face Spaces** using Docker and PostgreSQL, along with useful workflows for automation.

---

## 📂 Folder Structure

```
.
├── n8n-huggingface/
│   ├── huggingface/        # Instructions to host n8n on Hugging Face using Dockerfile & PostgreSQL
│   ├── .env                # Environment variables configuration
│   ├── Dockerfile          # Dockerfile to build image for Hugging Face Space
│   ├── package.json        # Community nodes or dependencies to install
│   ├── start.sh            # Startup script for n8n
│   ├── README.md           # Detailed deployment guide for Hugging Face
│
└── workflow/
    ├── keep-running.json    # Workflow to keep Hugging Face Space alive
    ├── other-workflows/     # Your other workflows
```

---

## 🔹 1. Host n8n on Hugging Face

Inside **`n8n-huggingface`**, you will find:

- **Dockerfile**: Configuration to run n8n in Hugging Face Space.
- **.env**: Update your environment variables.
- **package.json**: Define community nodes or packages to install.
- **start.sh**: Script to start n8n service.
- **Note**: Hugging Face Spaces may go to sleep when idle. To prevent this, see the workflow section below.

---

## 🔹 2. Workflow

The **`workflow/`** folder contains sample workflows:

- **keep-running.json**: A workflow that sends periodic requests to keep Hugging Face Space awake.
- Other workflows for your automation needs.

### How to use the workflow:
1. Open the n8n interface.
2. Import `workflow/keep-running.json`.
3. Update email, password and set up a trigger (e.g., every 24 hours) to send requests to your Hugging Face Space URL.

---

## 🚀 Quick Deployment Guide

1. Clone the repo:
   ```bash
   git clone https://github.com/<your-username>/<your-repo>.git
   cd <your-repo>/n8n-huggingface/huggingface
   ```

2. Update your configuration:
   - Edit `n8n-huggingface/.env` and `n8n-huggingface/package.json` as needed.

3. Deploy to Hugging Face Space:
   - Create a Space → select **Docker** → upload all files to your Space.
   - Configure secrets for: `N8N_ENCRYPTION_KEY`, `DB_POSTGRESDB_HOST`, `DB_POSTGRESDB_DATABASE`, `DB_POSTGRESDB_USER`, `DB_POSTGRESDB_PASSWORD`.

4. Import **keep-running.json** workflow into n8n to keep the Space alive.

---

## 📌 Notes

- Hugging Face Spaces have resource limits, so optimize Dockerfile and workflows to avoid overload.
- The **keep-running** workflow only needs to run periodically (e.g., every 24 hours).
- You can also duplicate my Space on Hugging Face: [n8n Space](https://huggingface.co/spaces/hieeus1402/n8n/)

---

## 💡 Future Ideas

- Add workflows integrating **Download Douyin Video**, **Upload Tiktok Video**, **Podcast Maker With Gemini**, or other services.
