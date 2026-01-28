# SKEDIO - Complete Setup & Implementation Guide

## Quick Start Commands

### Step 1: Clone the Repository
```bash
git clone https://github.com/siddharth-1118/skedio.git
cd skedio/frontend
```

### Step 2: Install Dependencies
```bash
npm install
# OR if you use bun
bun install
```

### Step 3: Install Required Packages
```bash
npm install next@latest react@latest react-dom@latest
npm install -D tailwindcss postcss autoprefixer typescript @types/react @types/node
npm install axios zustand
```

### Step 4: Initialize Tailwind
```bash
npx tailwindcss init -p
```

### Step 5: Create Folder Structure
Run these commands in the `frontend` directory:

```bash
# Create app directories
mkdir -p app/login
mkdir -p app/dashboard/timetable
mkdir -p app/dashboard/attendance
mkdir -p app/dashboard/marks

# Create components directories
mkdir -p components/ui
mkdir -p components/dashboard
mkdir -p components/auth

# Create utilities
mkdir -p lib/api
mkdir -p lib/utils
mkdir -p lib/hooks
mkdir -p store

# Create styles
mkdir -p styles
```

## File Structure to Create

### Step 6: Create Configuration Files

**Create `frontend/app/globals.css`:**
```css
@tailwind base;
@tailwind components;
@tailwind utilities;

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen';
  background-color: #f3f4f6;
}

.container {
  @apply max-w-7xl mx-auto px-4;
}

.btn-primary {
  @apply px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition;
}

.btn-secondary {
  @apply px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 transition;
}

.card {
  @apply bg-white rounded-lg shadow-md p-6;
}
```

### Step 7: Create Main Pages

**Create `frontend/app/page.tsx` (Home Page):**
```typescript
import Link from 'next/link';

export default function Home() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-600 to-indigo-700 flex items-center justify-center">
      <div className="text-center text-white">
        <h1 className="text-5xl font-bold mb-4">SKEDIO</h1>
        <p className="text-xl mb-8">Better Way to Manage Your Academics</p>
        <div className="space-x-4">
          <Link href="/login" className="btn-primary bg-white text-blue-600 hover:bg-gray-100">
            Login
          </Link>
          <Link href="/signup" className="btn-primary">
            Sign Up
          </Link>
        </div>
      </div>
    </div>
  );
}
```

**Create `frontend/app/login/page.tsx` (Login Page):**
```typescript
'use client';

import { useState } from 'react';
import Link from 'next/link';

export default function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log('Login:', { email, password });
    // API call will go here
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8">
        <div>
          <h1 className="text-3xl font-bold text-center text-gray-900">SKEDIO</h1>
          <h2 className="mt-6 text-center text-2xl font-bold text-gray-900">
            Sign in to your account
          </h2>
        </div>
        <form className="mt-8 space-y-6" onSubmit={handleSubmit}>
          <div className="rounded-md shadow-sm -space-y-px">
            <div>
              <label htmlFor="email-address" className="sr-only">
                Email address
              </label>
              <input
                id="email-address"
                name="email"
                type="email"
                autoComplete="email"
                required
                className="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 focus:z-10 sm:text-sm"
                placeholder="Email address"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
              />
            </div>
            <div>
              <label htmlFor="password" className="sr-only">
                Password
              </label>
              <input
                id="password"
                name="password"
                type="password"
                autoComplete="current-password"
                required
                className="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-b-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 focus:z-10 sm:text-sm"
                placeholder="Password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
              />
            </div>
          </div>

          <div>
            <button
              type="submit"
              className="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
            >
              Sign in
            </button>
          </div>
        </form>
        <p className="text-center text-sm text-gray-600">
          Don't have an account?{' '}
          <Link href="/signup" className="font-medium text-blue-600 hover:text-blue-500">
            Sign up
          </Link>
        </p>
      </div>
    </div>
  );
}
```

### Step 8: Run the Project

```bash
npm run dev
# OR
bun dev
```

The project will run on `http://localhost:3000`

## Key Features to Implement

1. **Authentication** - Login/Register with JWT
2. **Dashboard** - Main hub after login
3. **Timetable** - View and manage class schedule
4. **Attendance Tracker** - Track attendance percentage
5. **Marks Manager** - View grades and performance
6. **Profile** - User profile management

## API Endpoints (Backend)

Create these endpoints in your backend:

```
POST /api/auth/login
POST /api/auth/register
GET /api/user/profile
GET /api/courses
GET /api/attendance
POST /api/attendance
GET /api/marks
PUT /api/user/profile
```

## Database Schemas (MongoDB)

Use the Models from `frontend/models/Users.ts` as reference

## Environment Variables

Create `.env.local` in frontend folder:

```
NEXT_PUBLIC_API_URL=http://localhost:8000
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

## Troubleshooting

If you face issues:

1. Delete `node_modules` and `package-lock.json`, then run `npm install` again
2. Clear `.next` folder: `rm -rf .next`
3. Restart the dev server

## Next Steps

1. Implement authentication
2. Create API integration
3. Add dashboard components
4. Connect to MongoDB
5. Deploy to Vercel

Good luck with Skedio! 🚀
