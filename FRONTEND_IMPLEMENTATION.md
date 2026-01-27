# Skedio Frontend Implementation Guide

> **Complete guide for building the Skedio frontend with original UI/UX**

## Quick Start

```bash
# 1. Clone the repository
git clone --recurse-submodules https://github.com/siddharth-1118/skedio.git
cd skedio/frontend

# 2. Run setup script
bash ../setup.sh

# 3. Start development server
bun run dev
# or: npm run dev

# Visit http://localhost:3000
```

## Project Structure

```
frontend/
├── app/
│   ├── layout.tsx              # Root layout
│   ├── page.tsx                # Homepage
│   ├── (auth)/
│   │   ├── login/page.tsx
│   │   └── register/page.tsx
│   ├── (dashboard)/
│   │   ├── layout.tsx          # Dashboard layout with sidebar
│   │   ├── page.tsx            # Dashboard
│   │   ├── academia/page.tsx
│   │   ├── builder/page.tsx
│   │   ├── view/page.tsx
│   │   └── offline/page.tsx
│   └── api/                    # API routes
├── components/
│   ├── layouts/
│   │   ├── DashboardLayout.tsx
│   │   ├── Navbar.tsx
│   │   └── Sidebar.tsx
│   ├── cards/
│   │   ├── TimetableCard.tsx
│   │   ├── AttendanceCard.tsx
│   │   └── StatsCard.tsx
│   ├── ui/
│   │   ├── Button.tsx
│   │   ├── Card.tsx
│   │   ├── Input.tsx
│   │   └── Modal.tsx
│   └── shared/
│       ├── LoadingSpinner.tsx
│       ├── ErrorBoundary.tsx
│       └── ConfirmDialog.tsx
├── lib/
│   ├── supabase.ts            # Supabase client
│   ├── api.ts                 # API client
│   └── utils.ts               # Utility functions
├── hooks/
│   ├── useAuth.ts
│   ├── useAcademia.ts
│   └── useTimetable.ts
├── styles/
│   ├── globals.css
│   └── variables.css          # CSS variables for theming
├── public/
│   ├── logo.svg
│   ├── favicon.ico
│   └── images/
├── package.json
├── tsconfig.json
├── next.config.ts
├── tailwind.config.ts
└── .env.example
```

## Design System

### Colors (Dark Theme - Violet + Cyan)
```css
/* Primary */
--color-primary: #8b5cf6      /* Violet */
--color-primary-light: #a78bfa
--color-primary-dark: #6d28d9

/* Accent */
--color-accent: #06b6d4       /* Cyan */
--color-accent-light: #22d3ee
--color-accent-dark: #0891b2

/* Background */
--color-bg-primary: #0f172a    /* Dark blue */
--color-bg-secondary: #1e293b  /* Slightly lighter */
--color-bg-tertiary: #334155   /* Even lighter */

/* Text */
--color-text-primary: #f1f5f9
--color-text-secondary: #cbd5e1
--color-text-muted: #94a3b8

/* Status */
--color-success: #10b981
--color-warning: #f59e0b
--color-error: #ef4444
--color-info: #3b82f6
```

### Typography
```
Font Family: 'Inter', 'Segoe UI', Roboto, sans-serif
Headings: font-weight 600-700
Body: font-weight 400
Small: font-weight 500
```

## Core Pages Implementation

### 1. Authentication Pages

**`app/(auth)/login/page.tsx`**
- Email/password login form
- Social auth option (Google)
- Remember me checkbox
- Forgot password link
- Redirect to dashboard on success

**`app/(auth)/register/page.tsx`**
- Registration form (email, password, name)
- Email verification
- Terms acceptance
- Redirect to onboarding

### 2. Dashboard Layout

**`app/(dashboard)/layout.tsx`**
- Responsive sidebar (collapsible on mobile)
- Top navbar with user profile
- Main content area
- Protected route wrapper

### 3. Homepage (`app/(dashboard)/page.tsx`)

Display:
- Welcome message with user name
- Today's schedule (next 3 classes)
- Attendance overview (current percentage)
- CGPA display with trend
- Quick action cards:
  - View full timetable
  - Mark attendance
  - Check grades
  - View predictions

### 4. Academia Page (`app/(dashboard)/academia/page.tsx`)

Display:
- Complete SRM Academia data
- Timetable view (weekly/monthly)
- All courses list
- Attendance per course
- Grades and performance
- GPA calculator

### 5. Builder Page (`app/(dashboard)/builder/page.tsx`)

Display:
- Timetable customization interface
- Drag-and-drop class scheduling
- Color coding for subjects
- Save custom timetable
- Export as ICS calendar

### 6. View Page (`app/(dashboard)/view/page.tsx`)

Display:
- Generated timetable visualization
- Different view modes:
  - Grid/Table view
  - Calendar view
  - List view
- Print functionality
- Share options

## Key Components

### Design System Components

**Button Variants**
```tsx
// Primary (solid)
<Button variant="primary">Click me</Button>

// Secondary (outline)
<Button variant="secondary">Click me</Button>

// Ghost (minimal)
<Button variant="ghost">Click me</Button>

// Sizes: sm, md, lg
<Button size="lg">Large Button</Button>
```

**Card Component**
```tsx
<Card>
  <Card.Header>
    <Card.Title>Title</Card.Title>
    <Card.Description>Description</Card.Description>
  </Card.Header>
  <Card.Content>
    {/* Content */}
  </Card.Content>
  <Card.Footer>
    {/* Footer */}
  </Card.Footer>
</Card>
```

**Form Components**
```tsx
<Form>
  <FormField
    label="Email"
    name="email"
    type="email"
    placeholder="your@email.com"
  />
  <FormField
    label="Password"
    name="password"
    type="password"
  />
</Form>
```

## State Management

### Zustand Store Example

```typescript
// lib/store.ts
import { create } from 'zustand';

interface AuthStore {
  user: User | null;
  setUser: (user: User) => void;
  logout: () => void;
}

export const useAuthStore = create<AuthStore>((set) => ({
  user: null,
  setUser: (user) => set({ user }),
  logout: () => set({ user: null }),
}));
```

## API Integration

### Supabase Client Setup

```typescript
// lib/supabase.ts
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

export const supabase = createClient(supabaseUrl, supabaseKey);
```

### API Client

```typescript
// lib/api.ts
const API_BASE = process.env.NEXT_PUBLIC_API_URL;

export const api = {
  auth: {
    login: (email: string, password: string) =>
      fetch(`${API_BASE}/api/auth/login`, {
        method: 'POST',
        body: JSON.stringify({ email, password }),
      }),
  },
  academia: {
    getTimetable: () => fetch(`${API_BASE}/api/academia/timetable`),
    getAttendance: () => fetch(`${API_BASE}/api/academia/attendance`),
    getGrades: () => fetch(`${API_BASE}/api/academia/grades`),
  },
};
```

## Custom Hooks

### useAuth Hook

```typescript
// hooks/useAuth.ts
import { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase';

export function useAuth() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user || null);
      setLoading(false);
    });
  }, []);

  return { user, loading };
}
```

## Development Workflow

### 1. Setup Environment
```bash
cd frontend
bun install
cp .env.example .env.local
# Add your Supabase credentials
```

### 2. Start Dev Server
```bash
bun run dev
```

### 3. Build for Production
```bash
bun run build
bun run start
```

### 4. Linting & Type Checking
```bash
bun run lint
bun run type-check
```

## Database Schema (Supabase)

### Tables

**users**
- id (UUID, PK)
- email (TEXT, UNIQUE)
- name (TEXT)
- created_at (TIMESTAMP)
- updated_at (TIMESTAMP)

**timetables**
- id (UUID, PK)
- user_id (UUID, FK)
- data (JSONB)
- created_at (TIMESTAMP)
- updated_at (TIMESTAMP)

**academic_data**
- id (UUID, PK)
- user_id (UUID, FK)
- attendance (JSONB)
- grades (JSONB)
- cached_at (TIMESTAMP)

## Deployment

### Vercel Deployment

```bash
# Install Vercel CLI
bun install -g vercel

# Deploy
vercel

# Set environment variables in Vercel dashboard
```

### Environment Variables (Production)
```env
NEXT_PUBLIC_SUPABASE_URL=your_prod_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_prod_key
NEXT_PUBLIC_API_URL=your_api_url
```

## Performance Optimizations

1. **Image Optimization** - Use Next.js Image component
2. **Code Splitting** - Dynamic imports for routes
3. **Caching** - SWR/TanStack Query for data
4. **CSS Optimization** - Tailwind purging
5. **Font Optimization** - System fonts preferred

## Best Practices

✅ Use TypeScript for all files
✅ Component-based architecture
✅ Custom hooks for logic
✅ API routes for sensitive operations
✅ Environment variables for config
✅ Error boundaries for safety
✅ Loading states for UX
✅ Responsive design (mobile-first)
✅ Accessibility (a11y) compliance
✅ Regular testing & type checking

## Troubleshooting

**Port 3000 already in use?**
```bash
bun run dev -- -p 3001
```

**Supabase connection issues?**
- Verify credentials in .env.local
- Check Supabase project is active
- Confirm network access

**Build errors?**
```bash
bun run type-check  # Check TypeScript
bun run lint        # Check ESLint
```

## Next Steps

1. ✅ Clone & setup
2. ✅ Update Supabase credentials
3. ✅ Create auth pages
4. ✅ Build dashboard layout
5. ✅ Implement core pages
6. ✅ Connect APIs
7. ✅ Add styling & animations
8. ✅ Deploy to Vercel

## Resources

- [Next.js Docs](https://nextjs.org/docs)
- [Tailwind CSS](https://tailwindcss.com)
- [Supabase Auth](https://supabase.com/docs/guides/auth)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [React Hooks](https://react.dev/reference/react)

---

**Questions?** Check the main README or open a GitHub issue!
