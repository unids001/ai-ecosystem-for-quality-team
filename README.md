# AI Ecosystem for Quality Team

An AI ecosystem that elevates the whole QA team under unified project standards. It helps manual QCs build scenarios and learn code, boosts TAE productivity, and enables performance engineers to create load tests. Showcased via CODA AI Agents to highlight their capabilities, but open to any AI agent.

---

## 📋 Project Overview

This mono-repo contains automated test frameworks and AI-powered tools for QA teams:

| Module | Purpose | Tech Stack |
|--------|---------|-----------|
| **api-test-framework** | Lightweight API automation | Karate 2.1.2, Java 21, JUnit 5 |

---

## 🚀 Quick Start

### Prerequisites
- Java 21+
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
        ├── java/runners/
        │   └── TestRunner.java      (JUnit test runner)
        └── resources/
            ├── karate-config.js     (Environment configs)
            └── features/            (Test scenarios)
                └── orders/
                    └── order-creation.feature
```

### Key Features
✅ Karate 2.1.2 with modern Runner API  
✅ Multi-environment support (dev, staging, prod)  
✅ Tag-based test filtering  
✅ Parallel test execution (up to 5 threads)  
✅ Centralized dependency management (Maven multi-module)  
✅ HTML test reports
