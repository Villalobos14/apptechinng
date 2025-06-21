# Soft Skills App - Flutter Project

Una aplicación móvil diseñada para ayudar a estudiantes universitarios del área tecnológica a practicar y mejorar sus soft skills mediante IA personalizada.

## 🚀 Getting Started

### Prerrequisitos
- Flutter SDK (>=3.2.0)
- Dart SDK
- Android Studio / VS Code
- Git

### Instalación
```bash
# Clonar el repositorio
git clone <repository-url>
cd soft_skills_app

# Instalar dependencias
flutter pub get

# Ejecutar la app
flutter run
```

## 📁 Estructura del Proyecto

```
lib/
├── core/                    # Componentes fundamentales
├── shared/                  # Widgets y utilidades reutilizables
└── features/               # Módulos de funcionalidad
    ├── auth/              # Autenticación
    ├── home/              # Dashboard principal
    ├── practice/          # Módulo principal de práctica
    ├── tasks/             # Gestión de tareas
    ├── history/           # Historial y estadísticas
    ├── resources/         # Videos y recursos
    └── profile/           # Perfil del usuario
```

## 🏛️ Arquitectura

El proyecto sigue **Clean Architecture** con **Domain-Driven Design (DDD)**:

- **core/**: Configuración, errores, red, utilidades
- **shared/**: Widgets reutilizables, estilos, navegación
- **features/**: Cada feature contiene:
  - `domain/`: Entidades, casos de uso, repositorios (interfaces)
  - `data/`: Implementaciones, DTOs, fuentes de datos
  - `presentation/`: Pages, widgets, view models
  - `application/`: Inyección de dependencias

## 🎨 Sistema de Diseño

### Colores
- **Primary**: `AppColors.primary` - Azul tecnológico
- **Secondary**: `AppColors.secondary` - Verde éxito
- **Accent**: `AppColors.accent` - Naranja motivacional

### Tipografías
- **Headlines**: `AppTextStyles.headlineLarge/Medium/Small`
- **Body**: `AppTextStyles.bodyLarge/Medium/Small`
- **Labels**: `AppTextStyles.labelLarge/Medium/Small`

### Espaciados
- **Padding**: `AppDimensions.paddingSmall/Medium/Large`
- **Spacing**: `AppDimensions.spacingSmall/Medium/Large`
- **Radius**: `AppDimensions.radiusSmall/Medium/Large`

## 🌿 Estrategia de Branches

### Branch Principal
- `main`: Código estable y listo para producción

### Branches de Desarrollo
- `develop`: Branch de integración para desarrollo

### Branches de Features
Usar la convención: `feature/[feature-name]-[short-description]`

**Ejemplos:**
```bash
feature/auth-login-implementation
feature/practice-soft-skills-module
feature/home-dashboard-ui
feature/gamification-progress-system
```

### Branches de Bug Fixes
Usar la convención: `bugfix/[issue-description]`

**Ejemplos:**
```bash
bugfix/login-validation-error
bugfix/practice-timer-not-stopping
```

### Branches de Hotfixes
Para fixes urgentes en producción: `hotfix/[critical-issue]`

**Ejemplos:**
```bash
hotfix/auth-token-expiration
hotfix/app-crash-on-startup
```

## 📝 Convención de Commits

Usar **Conventional Commits** con la siguiente estructura:
```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Tipos de Commits

#### Features y Desarrollo
- `feat`: Nueva funcionalidad
- `ui`: Cambios en interfaz de usuario
- `style`: Cambios en estilos (CSS, themes, etc.)

#### Mantenimiento
- `fix`: Corrección de bugs
- `refactor`: Refactorización de código
- `perf`: Mejoras de performance
- `docs`: Documentación

#### Configuración
- `build`: Cambios en build system o dependencias
- `ci`: Cambios en CI/CD
- `test`: Agregar o modificar tests

#### Otros
- `chore`: Tareas de mantenimiento
- `revert`: Revertir commits anteriores

### Scopes Sugeridos
- `auth`: Autenticación
- `home`: Dashboard principal
- `practice`: Módulo de práctica
- `tasks`: Gestión de tareas
- `history`: Historial
- `resources`: Videos y recursos
- `shared`: Componentes compartidos
- `core`: Configuración base
- `navigation`: Sistema de navegación

### Ejemplos de Commits

```bash
# Features
feat(auth): implement login with email validation
feat(practice): add soft skills learning journey module
feat(gamification): implement points and streak system

# UI/UX
ui(home): design dashboard with progress cards
ui(practice): create quiz question widget
style(shared): update color palette and typography

# Bug fixes
fix(auth): resolve login form validation issues
fix(practice): fix timer not resetting between sessions

# Refactoring
refactor(practice): extract common widgets to shared
refactor(core): improve error handling structure

# Documentation
docs(readme): update setup instructions
docs(architecture): add clean architecture guidelines

# Build/Config
build(deps): upgrade flutter to 3.16.0
build(assets): add lottie animations support

# Tests
test(auth): add unit tests for login use case
test(practice): add widget tests for quiz components
```

### Commits Multi-línea (Para cambios complejos)

```bash
feat(practice): implement AI feedback system

- Add AIFeedbackService for API communication
- Create feedback display widgets
- Implement scoring algorithm
- Add feedback persistence

Closes #123
```

## 🔄 Workflow de Development

### 1. Crear Feature Branch
```bash
git checkout develop
git pull origin develop
git checkout -b feature/auth-login-implementation
```

### 2. Desarrollo y Commits
```bash
git add .
git commit -m "feat(auth): implement login form validation"
git push origin feature/auth-login-implementation
```

### 3. Pull Request
- Crear PR desde feature branch hacia `develop`
- Agregar descripción detallada
- Solicitar code review
- Mergear después de approval

### 4. Deploy
```bash
# Merge develop -> main para releases
git checkout main
git merge develop
git tag v1.0.0
git push origin main --tags
```

## 👥 División de Trabajo Sugerida

### Developer 1: Backend Integration & Core Features
- Módulo de autenticación completo
- Integración con APIs backend
- Módulo de práctica (casos de uso principales)
- Sistema de navegación

### Developer 2: UI/UX & Gamification
- Sistema de diseño y widgets compartidos
- Dashboard y componentes de gamificación
- Módulos de historial y recursos
- Animaciones y micro-interacciones

### Colaboración Shared
- Revisar PRs mutuamente
- Pair programming en features complejas
- Definir APIs internas entre módulos
- Testing y debugging conjunto

## 🧪 Testing

### Estructura de Tests
```
test/
├── unit/                   # Tests unitarios
├── widget/                 # Tests de widgets
├── integration/            # Tests de integración
└── golden/                 # Golden tests para UI
```

### Comandos de Testing
```bash
# Todos los tests
flutter test

# Solo unit tests
flutter test test/unit

# Coverage
flutter test --coverage
```

## 📱 Assets

### Imágenes
- Colocar en `assets/images/`
- Formato: PNG, JPG, WebP
- Usar 2x, 3x para diferentes densidades

### Iconos
- Colocar en `assets/icons/`
- Preferir SVG o iconos vectoriales

### Animaciones Lottie
- Colocar en `assets/animations/`
- Formato: JSON de Lottie Files
- Usar para micro-interacciones y gamificación

### Fuentes
- Colocar en `assets/fonts/`
- Inter font family incluida por defecto

## 🚀 Build & Deploy

### Development
```bash
flutter run --debug
```

### Release
```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS  
flutter build ios --release
```

## 📋 Checklist Antes de Commit

- [ ] Código compile sin errores
- [ ] Tests pasan exitosamente
- [ ] Seguir convenciones de naming
- [ ] Actualizar documentación si es necesario
- [ ] Commit message sigue convención
- [ ] No incluir archivos sensibles (keys, tokens)

## 🤝 Contribuir

1. Fork el repositorio
2. Crear feature branch
3. Hacer cambios siguiendo las convenciones
4. Agregar tests si es necesario
5. Crear Pull Request con descripción detallada

## 📞 Contacto

Para dudas sobre el proyecto, contactar al equipo de desarrollo.
