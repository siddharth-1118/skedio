# 🚀 SKEDIO - QUICK START IMPLEMENTATION GUIDE

## ⚡ 5-MINUTE QUICK START

Follow these steps EXACTLY to implement Skedio:

### Step 0: Initial Setup
```bash
cd frontend
npm install mongoose axios
echo "MONGODB_URI=mongodb+srv://saisiddharthvooka:vSs@11182007@cluster0.3f9n7v3.mongodb.net/?appName=Cluster0" > .env.local
echo ".env.local" >> .gitignore
```

---

## 📁 FILE STRUCTURE - CREATE THESE FILES

### 1️⃣ CREATE: `frontend/lib/mongodb.ts`

```typescript
import mongoose from 'mongoose';

let cached = global.mongoose;
if (!cached) {
  cached = global.mongoose = { conn: null, promise: null };
}

export async function connectDB() {
  if (cached.conn) return cached.conn;
  if (!cached.promise) {
    const opts = { bufferCommands: false };
    const uri = process.env.MONGODB_URI!;
    cached.promise = mongoose.connect(uri, opts);
  }
  cached.conn = await cached.promise;
  return cached.conn;
}
```

---

### 2️⃣ CREATE: `frontend/models/User.ts`

```typescript
import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  password: String,
  name: { type: String, required: true },
  rollNo: { type: String, unique: true },
  department: String,
  semester: Number,
  createdAt: { type: Date, default: Date.now },
});

export default mongoose.models.User || mongoose.model('User', userSchema);
```

### 3️⃣ CREATE: `frontend/models/Class.ts`

```typescript
import mongoose from 'mongoose';

const classSchema = new mongoose.Schema({
  name: { type: String, required: true },
  code: { type: String, unique: true },
  instructor: String,
  schedule: [{
    day: String,
    start: String,
    end: String,
    room: String
  }],
  semester: Number,
  createdAt: { type: Date, default: Date.now },
});

export default mongoose.models.Class || mongoose.model('Class', classSchema);
```

### 4️⃣ CREATE: `frontend/models/Attendance.ts`

```typescript
import mongoose from 'mongoose';

const attendanceSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  classId: { type: mongoose.Schema.Types.ObjectId, ref: 'Class' },
  present: { type: Boolean, default: false },
  date: { type: Date, default: Date.now },
});

export default mongoose.models.Attendance || mongoose.model('Attendance', attendanceSchema);
```

### 5️⃣ CREATE: `frontend/models/Assignment.ts`

```typescript
import mongoose from 'mongoose';

const assignmentSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: String,
  classId: { type: mongoose.Schema.Types.ObjectId, ref: 'Class' },
  dueDate: Date,
  marks: { type: Number, default: 100 },
  submittedBy: [{
    userId: mongoose.Schema.Types.ObjectId,
    submittedAt: Date
  }],
  createdAt: { type: Date, default: Date.now },
});

export default mongoose.models.Assignment || mongoose.model('Assignment', assignmentSchema);
```

---

## 🔌 API ROUTES - CREATE THESE

### 6️⃣ CREATE: `frontend/app/api/test-db/route.ts`

```typescript
import { connectDB } from '@/lib/mongodb';
import { NextResponse } from 'next/server';

export async function GET() {
  try {
    await connectDB();
    return NextResponse.json({ success: true, message: 'Connected to MongoDB!' });
  } catch (error) {
    return NextResponse.json({ success: false, error: String(error) }, { status: 500 });
  }
}
```

### 7️⃣ CREATE: `frontend/app/api/users/route.ts`

```typescript
import { connectDB } from '@/lib/mongodb';
import User from '@/models/User';
import { NextRequest, NextResponse } from 'next/server';

export async function GET() {
  try {
    await connectDB();
    const users = await User.find({});
    return NextResponse.json({ success: true, data: users });
  } catch (error) {
    return NextResponse.json({ success: false, error: String(error) }, { status: 500 });
  }
}

export async function POST(request: NextRequest) {
  try {
    await connectDB();
    const body = await request.json();
    const user = new User(body);
    await user.save();
    return NextResponse.json({ success: true, data: user }, { status: 201 });
  } catch (error) {
    return NextResponse.json({ success: false, error: String(error) }, { status: 400 });
  }
}
```

### 8️⃣ CREATE: `frontend/app/api/classes/route.ts`

```typescript
import { connectDB } from '@/lib/mongodb';
import Class from '@/models/Class';
import { NextRequest, NextResponse } from 'next/server';

export async function GET() {
  try {
    await connectDB();
    const classes = await Class.find({});
    return NextResponse.json({ success: true, data: classes });
  } catch (error) {
    return NextResponse.json({ success: false, error: String(error) }, { status: 500 });
  }
}

export async function POST(request: NextRequest) {
  try {
    await connectDB();
    const body = await request.json();
    const classData = new Class(body);
    await classData.save();
    return NextResponse.json({ success: true, data: classData }, { status: 201 });
  } catch (error) {
    return NextResponse.json({ success: false, error: String(error) }, { status: 400 });
  }
}
```

---

## 🎨 PAGES - CREATE THESE

### 9️⃣ CREATE: `frontend/app/page.tsx` (HOME PAGE)

```typescript
'use client';

export default function Home() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-indigo-600 via-purple-600 to-pink-600 flex items-center justify-center">
      <div className="text-center text-white">
        <h1 className="text-6xl font-bold mb-4">🎓 Skedio</h1>
        <p className="text-2xl mb-8">Better way to manage your academics</p>
        <div className="space-y-4">
          <button className="px-8 py-3 bg-white text-purple-600 rounded-lg font-bold hover:bg-gray-100">
            Get Started
          </button>
          <p className="text-gray-200">Student Portal • Timetable • Attendance • Grades</p>
        </div>
      </div>
    </div>
  );
}
```

### 🔟 CREATE: `frontend/app/dashboard/page.tsx`

```typescript
'use client';

use client';
import { useEffect, useState } from 'react';

export default function Dashboard() {
  const [stats, setStats] = useState({ users: 0, classes: 0 });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const usersRes = await fetch('/api/users');
        const classesRes = await fetch('/api/classes');
        const users = await usersRes.json();
        const classes = await classesRes.json();
        setStats({
          users: users.data?.length || 0,
          classes: classes.data?.length || 0
        });
      } catch (error) {
        console.error('Error fetching stats:', error);
      } finally {
        setLoading(false);
      }
    };
    fetchStats();
  }, []);

  return (
    <div className="p-8 bg-gradient-to-br from-slate-900 to-slate-800 min-h-screen text-white">
      <h1 className="text-4xl font-bold mb-8">Dashboard</h1>
      {loading ? (
        <p>Loading...</p>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div className="bg-indigo-600 p-6 rounded-lg">
            <h2 className="text-2xl font-bold">👥 Users</h2>
            <p className="text-5xl font-bold mt-4">{stats.users}</p>
          </div>
          <div className="bg-purple-600 p-6 rounded-lg">
            <h2 className="text-2xl font-bold">📚 Classes</h2>
            <p className="text-5xl font-bold mt-4">{stats.classes}</p>
          </div>
        </div>
      )}
    </div>
  );
}
```

---

## ✅ TESTING - RUN THESE COMMANDS

### Run Development Server
```bash
npm run dev
# Visit http://localhost:3000
```

### Test MongoDB Connection
```bash
curl http://localhost:3000/api/test-db
# Expected: {"success":true,"message":"Connected to MongoDB!"}
```

### Create a User
```bash
curl -X POST http://localhost:3000/api/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@example.com","rollNo":"21CS001","semester":3}'
```

### Get All Users
```bash
curl http://localhost:3000/api/users
```

---

## 📋 CHECKLIST - DO THIS NOW

- [ ] Create `.env.local` with MongoDB URI
- [ ] Create all model files (User, Class, Attendance, Assignment)
- [ ] Create all API routes (test-db, users, classes)
- [ ] Create HomePage and Dashboard
- [ ] Run `npm run dev`
- [ ] Test endpoints with curl
- [ ] Commit to GitHub

---

## 🎉 YOU'RE DONE!

You now have:
✅ MongoDB connected
✅ Mongoose models
✅ REST API endpoints
✅ Dashboard page
✅ Working foundation

**Next:** Add more pages (timetable, attendance, grades) following the same pattern!

Goodnight! Sleep well! 😴
