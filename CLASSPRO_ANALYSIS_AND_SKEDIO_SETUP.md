# ClassPro Analysis & Skedio Setup (Based on ClassPro Structure)

## 📊 ClassPro Architecture Analysis

### Key Understanding from ClassPro:

**ClassPro is a MONOREPO with:**
1. **Frontend**: Next.js application running on **http://localhost:0243**
2. **Backend**: Go language API running on **http://localhost:8080**
3. **Package Manager**: Uses **Bun** (not npm)
4. **Tech Stack**:
   - Frontend: Next.js, TypeScript, Tailwind CSS, Supabase
   - Backend: Go, Custom Go Scraper
   - Database: Supabase (PostgreSQL)

### ClassPro Setup Instructions:

```bash
git clone --recurse-submodules https://github.com/rahuletto/classpro
cd classpro
bun install
bun run install:all
bun run dev
```

### ClassPro Scripts:

```json
"dev": "bun run sync:env && concurrently \"bun run dev:frontend\" \"bun run dev:backend\""
"dev:frontend": "cd frontend && bun run dev"          // Runs on port 0243
"dev:backend": "cd backend && go run src/main.go"    // Runs on port 8080
```

---

## 🎯 SKEDIO Setup Instructions (Following ClassPro Pattern)

### Important: Use NPM (Not Bun) + Next.js 14 (Same as ClassPro)

### **STEP 1: Clone Your Skedio Repository**

```bash
git clone https://github.com/siddharth-1118/skedio.git
cd skedio
```

### **STEP 2: Update Root package.json**

Add this `package.json` in the root folder of your skedio project:

```json
{
  "name": "skedio-monorepo",
  "version": "1.0.0",
  "private": true,
  "workspaces": [
    "frontend"
  ],
  "scripts": {
    "dev": "cd frontend && npm run dev",
    "dev:frontend": "cd frontend && npm run dev",
    "build": "cd frontend && npm run build",
    "start": "cd frontend && npm run start",
    "install:all": "npm install && cd frontend && npm install"
  }
}
```

### **STEP 3: Install Dependencies**

In `C:\Users\saisi\skedio` (root folder):

```bash
npm install
```

Then navigate to frontend:

```bash
cd frontend
npm install
```

### **STEP 4: Install Required Frontend Packages**

```bash
npm install next@latest react@latest react-dom@latest
npm install -D tailwindcss postcss autoprefixer typescript @types/react @types/node @types/react-dom --legacy-peer-deps
npm install axios zustand
```

### **STEP 5: Create Environment File**

Create `.env.local` in `frontend` folder:

```env
NEXT_PUBLIC_API_URL=http://localhost:8080
NEXT_PUBLIC_APP_URL=http://localhost:0243
PORT=0243
```

### **STEP 6: Update Frontend package.json**

Modify `frontend/package.json` scripts to:

```json
"scripts": {
  "dev": "next dev -p 0243",
  "build": "next build",
  "start": "next start -p 0243",
  "lint": "next lint"
}
```

### **STEP 7: Create Folder Structure**

Run these Windows commands in `frontend` folder:

```bash
md app\login
md app\dashboard\timetable
md app\dashboard\attendance  
md app\dashboard\marks
md components\ui
md components\dashboard
md components\auth
md lib\api
md lib\utils
md lib\hooks
md store
md styles
```

### **STEP 8: Start Development Server**

```bash
cd frontend
npm run dev
```

**App will run at:** `http://localhost:0243` ✅

---

## 📁 Folder Structure (Following ClassPro Pattern)

```
skedio/
├── frontend/                      # Next.js Frontend
│   ├── app/
│   │   ├── layout.tsx
│   │   ├── page.tsx
│   │   ├── globals.css
│   │   ├── login/
│   │   └── dashboard/
│   ├── components/
│   │   ├── ui/
│   │   ├── auth/
│   │   └── dashboard/
│   ├── lib/
│   │   ├── api/
│   │   ├── utils/
│   │   └── hooks/
│   ├── types/               ✅ Already created
│   ├── models/              ✅ Already created
│   ├── next.config.js       ✅ Created
│   ├── tailwind.config.ts   ✅ Created  
│   ├── .env.local           (Create this)
│   └── package.json
├── backend/                       # Will create later (Go/Node)
├── package.json                   # Root monorepo config
└── README.md
```

---

## 🔐 Environment Variables Setup

### For Supabase (Following ClassPro):

**Root `.env` file:**

```env
SUPABASE_URL="your_supabase_url"
SUPABASE_KEY="your_supabase_anon_key"
VALIDATION_KEY="your_validation_key"
ENCRYPTION_KEY="your_encryption_key"
```

**Frontend `.env.local` file:**

```env
NEXT_PUBLIC_API_URL=http://localhost:8080
NEXT_PUBLIC_APP_URL=http://localhost:0243
NEXT_PUBLIC_SUPABASE_URL=${SUPABASE_URL}
NEXT_PUBLIC_SUPABASE_KEY=${SUPABASE_KEY}
PORT=0243
```

### Generate Encryption Keys:

**Windows PowerShell:**
```powershell
[BitConverter]::ToString((New-Object Security.Cryptography.RNGCryptoServiceProvider).GetBytes(32)).Replace("-", "").ToLower()
```

---

## 🚀 Complete Command List (Windows)

```bash
# Clone and navigate
git clone https://github.com/siddharth-1118/skedio.git
cd skedio

# Install root dependencies
npm install

# Go to frontend
cd frontend

# Install frontend packages
npm install
npm install next@latest react@latest react-dom@latest
npm install -D tailwindcss postcss autoprefixer typescript @types/react @types/node @types/react-dom --legacy-peer-deps
npm install axios zustand

# Create folders
md app\login
md app\dashboard\timetable
md app\dashboard\attendance
md app\dashboard\marks
md components\ui
md components\dashboard
md components\auth
md lib\api
md lib\utils
md lib\hooks
md store
md styles

# Start dev server on port 0243
npm run dev
```

---

## 🎨 File Templates Already Provided

✅ **Configuration Files:**
- next.config.js
- tailwind.config.ts
- app/layout.tsx (Root layout)

✅ **Type Definitions:**
- Users.ts (Mongoose)
- Course.ts
- Timetable.ts
- Attendance.ts
- Marks.ts
- Grade.ts

---

## 📱 Next Steps:

1. ✅ Clone repo and install dependencies
2. ✅ Create folder structure
3. ✅ Start development server on port 0243
4. 🔄 Create authentication pages
5. 🔄 Create dashboard components
6. 🔄 Connect to Supabase database
7. 🔄 Implement API integration
8. 🔄 Deploy to Vercel

---

## 🔗 Port Configuration

| Service | Port | URL |
|---------|------|-----|
| Frontend (Skedio) | 0243 | http://localhost:0243 |
| Backend (Future) | 8080 | http://localhost:8080 |

---

## ✨ Key Differences from ClassPro:

| Feature | ClassPro | Skedio |
|---------|----------|--------|
| Package Manager | Bun | NPM |
| Backend | Go | Will Add |
| Database | Supabase | MongoDB (for now) |
| Frontend | Next.js 14 | Next.js 14 |
| UI Changes | Minimal | ✅ Complete Redesign |
| Port | 0243 | 0243 |

---

Good luck building Skedio! 🚀
