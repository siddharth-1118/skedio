# Skedio

> **Better way to manage your academics.** A student portal for scheduling, attendance tracking, and academic performance prediction.

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-CC%20BY--NC--ND-green.svg)
![TypeScript](https://img.shields.io/badge/typescript-5.3-blue.svg)

## Overview

Skedio is a comprehensive student academic management platform built with modern web technologies. It provides a seamless experience for managing timetables, tracking attendance, and predicting academic performance. The application is built as a monorepo with a Next.js frontend and Go backend.

### Features

- 🎓 **Timetable Management** - View and customize your class schedule
- 📊 **Attendance Tracking** - Monitor and predict attendance percentages
- 📈 **CGPA Calculator** - Calculate your cumulative GPA in real-time
- 🔮 **Performance Prediction** - AI-powered academic predictions
- 📱 **Mobile-First Design** - Optimized for all devices
- 🔐 **Secure Authentication** - Supabase-powered auth
- 🌙 **Dark Mode Support** - Eye-friendly interface
- 📴 **Offline Mode** - Access cached data without internet

## Monorepo Structure

```
skedio/
├── frontend/          # Next.js 15 frontend application
│   ├── app/          # App router pages and layouts
│   ├── components/   # Reusable React components
│   ├── lib/          # Utility functions and helpers
│   ├── hooks/        # Custom React hooks
│   ├── styles/       # Tailwind CSS configuration
│   └── public/       # Static assets
├── backend/          # Go backend API (submodule)
│   ├── cmd/          # Command line applications
│   ├── internal/     # Private application code
│   ├── pkg/          # Public packages
│   └── main.go       # Entry point
├── .gitmodules       # Git submodules config
├── docker-compose.yml # Docker services
├── Makefile          # Build automation
└── README.md         # This file
```

## Prerequisites

- **Node.js** >= 18.0.0
- **Bun** >= 1.2.0 (recommended package manager)
- **Go** >= 1.21.0 (for backend)
- **Docker** & **Docker Compose** (optional, for containerized deployment)
- **Git** with submodule support

## Environment Variables

Create a `.env.local` file in the project root:

```env
# Shared Configuration
SUPABASE_URL=your_supabase_url
SUPABASE_KEY=your_supabase_anon_key
VALIDATION_KEY=your_validation_key_64_char
ENCRYPTION_KEY=your_encryption_key_64_char

# Frontend Specific
NEXT_PUBLIC_URL=http://localhost:8080
NEXT_PUBLIC_SUPABASE_URL=${SUPABASE_URL}
NEXT_PUBLIC_SUPABASE_KEY=${SUPABASE_KEY}
NEXT_PUBLIC_VALIDATION_KEY=${VALIDATION_KEY}

# Backend Specific  
PORT=8080
DATABASE_URL=postgresql://user:password@localhost:5432/skedio
```

## Quick Start

### Installation

```bash
# Clone with submodules
git clone --recurse-submodules https://github.com/siddharth-1118/skedio.git
cd skedio

# Install dependencies (Bun recommended)
bun install

# Or using npm
npm install
```

### Development

```bash
# Start frontend (http://localhost:3000)
bun run dev:frontend

# Or start backend (http://localhost:8080)
bun run dev:backend

# Or run both simultaneously
bun run dev
```

### Production Build

```bash
# Build both services
bun run build

# Build individually
bun run build:frontend
bun run build:backend
```

### Docker Deployment

```bash
# Build and start services
bun run docker:build
bun run docker:up

# Stop services
bun run docker:down
```

## Tech Stack

### Frontend
- **Framework**: Next.js 15 (App Router)
- **Language**: TypeScript 5.3
- **Styling**: Tailwind CSS 3.4
- **State**: Zustand + TanStack Query
- **Database**: Supabase (PostgreSQL)
- **Auth**: Supabase Auth
- **UI Components**: shadcn/ui (optional)

### Backend
- **Language**: Go 1.21+
- **Framework**: Fiber
- **Database**: PostgreSQL
- **Scraper**: Custom SRM Academia scraper

### DevOps
- **Containerization**: Docker
- **Package Manager**: Bun / npm
- **Version Control**: Git
- **Deployment**: Vercel (frontend) / Custom VPS (backend)

## API Endpoints

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/logout` - User logout
- `POST /api/auth/register` - User registration
- `GET /api/auth/profile` - Get user profile

### Academia
- `GET /api/academia/timetable` - Get user timetable
- `GET /api/academia/attendance` - Get attendance data
- `GET /api/academia/grades` - Get grades and CGPA
- `GET /api/academia/courses` - Get enrolled courses

### Analytics
- `GET /api/analytics/predictions` - Get academic predictions
- `GET /api/analytics/statistics` - Get performance stats

## Pages

### Core Pages
- `/` - Dashboard homepage
- `/academia` - Full SRM Academia data view
- `/builder` - Timetable builder/customizer
- `/view` - Generated timetable view
- `/auth/login` - Login page
- `/auth/register` - Registration page

### Utility Pages
- `/privacy` - Privacy policy
- `/offline` - Offline mode fallback
- `/suspended` - Account suspension notice
- `/sleeping` - Inactive account notice
- `/invalid` - Invalid state handler

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under CC BY-NC-ND 4.0. See LICENSE file for details.

### You are free to:
- **Share** - Copy and redistribute the material

### Under the following terms:
- **Attribution** - Give appropriate credit
- **NonCommercial** - Not for commercial purposes
- **NoDerivatives** - Cannot modify or build upon

## Acknowledgments

- **Inspired by**: [ClassPro](https://github.com/Rahuletto/ClassPro) - Original academic management platform
- **SRM Institute of Science and Technology** - For the academia system
- **Community** - All contributors and users

## Support

For issues and feature requests, please open a GitHub issue:
- [Report a Bug](https://github.com/siddharth-1118/skedio/issues/new?template=bug.md)
- [Request a Feature](https://github.com/siddharth-1118/skedio/issues/new?template=feature.md)

## Roadmap

- [ ] Mobile app (React Native)
- [ ] Advanced analytics dashboard
- [ ] Study material integration
- [ ] Exam scheduler
- [ ] Grade prediction ML model
- [ ] Multi-university support
- [ ] Real-time notifications
- [ ] Collaborative study tools

## Getting Help

- 📖 [Read the Documentation](./docs/README.md)
- 💬 [Join Discord Community](https://discord.gg/skedio)
- 🐛 [Report Issues](https://github.com/siddharth-1118/skedio/issues)
- 💡 [Suggest Features](https://github.com/siddharth-1118/skedio/discussions)

---

**Made with ❤️ by [Siddharth](https://github.com/siddharth-1118)**

*Last updated: January 27, 2026*
