# CAPTCHA Bypass Tools

This component provides tools for handling and bypassing CAPTCHA challenges, specifically reCAPTCHA v2.

## 🔧 Configuration

The component uses `config.json` to store reCAPTCHA keys and settings:

```json
{
  "recaptcha": {
    "site_key": "6Le6oJErAAAAAK-7J1sth4mLEkWnFW2rD4r5CXUB",
    "secret_key": "6Le6oJErAAAAANFP9XxMvp3yiyyBR_m3blKNJ7gL",
    "version": "v2",
    "type": "checkbox"
  },
  "settings": {
    "timeout": 30000,
    "retry_attempts": 3,
    "auto_solve": true
  }
}
```

## 🚀 Quick Start

1. **Install dependencies:**
```bash
pip install -r requirements.txt
```

2. **Run the reCAPTCHA solver:**
```bash
python recaptcha_solver.py
```

## 📁 Files

- `config.json` - Configuration file with reCAPTCHA keys
- `recaptcha_solver.py` - Main solver class and utilities
- `requirements.txt` - Python dependencies

## 🔑 Features

- **reCAPTCHA v2 Support**: Handle checkbox-based reCAPTCHA
- **Token Verification**: Verify reCAPTCHA response tokens
- **HTML Generation**: Generate reCAPTCHA HTML elements
- **Auto-solving**: Framework for automated CAPTCHA solving
- **Error Handling**: Robust error handling and logging

## 🛠️ Usage

### Basic Usage

```python
from recaptcha_solver import ReCaptchaSolver

# Initialize solver
solver = ReCaptchaSolver()

# Generate HTML for a form
html = solver.generate_site_key_script()
print(html)

# Verify a response token
is_valid = solver.verify_recaptcha("response_token_here")
print(f"Valid: {is_valid}")
```

### Advanced Usage

```python
# Custom configuration
solver = ReCaptchaSolver("custom_config.json")

# Solve CAPTCHA automatically
token = solver.solve_captcha("https://example.com/form")
if token:
    print(f"Solved token: {token}")
```

## ⚠️ Important Notes

- The provided keys are for testing purposes
- Auto-solving features require additional implementation
- Always comply with website terms of service
- Use responsibly and ethically

## 🔒 Security

- Keep your secret keys secure
- Don't commit keys to version control
- Use environment variables in production

## 📝 License

This component is part of the iHuman project. 