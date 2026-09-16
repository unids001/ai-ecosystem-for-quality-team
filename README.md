# AI Ecosystem for Quality Team

An AI ecosystem that elevates the whole QA team under unified project standards. It helps manual QCs build scenarios and learn code, boosts TAE productivity, and enables performance engineers to create load tests. Showcased via CODA AI Agents to highlight their capabilities, but open to any AI agent.

---

## 📋 Project Overview

This mono-repo contains automated test frameworks and AI-powered tools for QA teams:

| Module | Purpose | Tech Stack |
|--------|---------|-----------|
| **api-test-framework** | Lightweight API automation | Karate DSL, Java 17, JUnit 5 |

---

## 🚀 Quick Start

### Prerequisites
- Java 17+
- Maven 3.8+

### Setup
```bash
# Clone repository
git clone <repo-url>
cd ai-ecosystem-for-quality-team

# Run all tests
mvn clean test

# Run with specific environment
mvn test -Dkarate.env=dev

# Run by tags
mvn test -Dkarate.options="--tags @smoke"
```

### Project Structure
```
ai-ecosystem-for-quality-team/
├── pom.xml                          (Parent: Manages versions & plugins)
└── api-test-framework/              (Module 1)
    ├── pom.xml                      (Module: Inherits from parent)
    └── src/test/
        ├── java/runners/            (Test runner class)
        └── resources/
            ├── karate-config.js     (Environment configs)
            └── features/            (Test scenarios)
                ├── users/
                └── posts/
```

### Key Features
✅ Lightweight & fast API testing  
✅ Multi-environment support (dev, staging, prod)  
✅ Tag-based test filtering  
✅ Parallel test execution  
✅ Centralized dependency management  

---

## 📝 Next Steps
- Add sample feature files (users, posts)
- Integrate CI/CD pipeline
- Add AI-powered test generation tools
