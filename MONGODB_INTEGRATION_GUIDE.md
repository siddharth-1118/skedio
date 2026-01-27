# MongoDB Integration Guide for Skedio

## Overview
This guide provides step-by-step instructions to integrate MongoDB with your Skedio backend (Next.js).

## MongoDB Atlas Setup (COMPLETED)

### Project Details
- **Project Name**: Skedio
- **Database Cluster**: Cluster0
- **Tier**: FREE (512 MB, forever free)
- **Region**: AWS (ap-south-1)

### Database Credentials
- **Username**: `saisiddharthvooka`
- **Password**: `vSs@11182007`
- **Connection String**: `mongodb+srv://saisiddharthvooka:vSs@11182007@cluster0.3f9n7v3.mongodb.net/?appName=Cluster0`

---

## Step 1: Install Dependencies

### Option A: Using Mongoose (Recommended for Schema Management)

```bash
cd frontend
npm install mongoose
```

### Option B: Using Native MongoDB Driver

```bash
cd frontend
npm install mongodb
```

---

## Step 2: Set Up Environment Variables

### Create `.env.local` in the `frontend` directory

```bash
cd frontend
echo 'MONGODB_URI=mongodb+srv://saisiddharthvooka:vSs@11182007@cluster0.3f9n7v3.mongodb.net/?appName=Cluster0' > .env.local
```

### Or manually create `frontend/.env.local` with:

```
MONGODB_URI=mongodb+srv://saisiddharthvooka:vSs@11182007@cluster0.3f9n7v3.mongodb.net/?appName=Cluster0
NEXT_PUBLIC_ENV=development
```

**⚠️ IMPORTANT**: Add `.env.local` to `.gitignore` to keep credentials safe!

```bash
echo ".env.local" >> frontend/.gitignore
```

---

## Step 3: Create MongoDB Connection File

### Create `frontend/lib/mongodb.ts` (TypeScript)

```typescript
import { MongoClient } from 'mongodb';

const uri = process.env.MONGODB_URI;
let cachedClient: MongoClient | null = null;

export async function connectToDatabase() {
  if (cachedClient) {
    return cachedClient;
  }

  if (!uri) {
    throw new Error('MONGODB_URI is not defined');
  }

  const client = new MongoClient(uri);
  await client.connect();
  cachedClient = client;
  return client;
}

export async function getDatabase() {
  const client = await connectToDatabase();
  return client.db('skedio');
}
```

### Or using Mongoose `frontend/lib/mongodb.ts`

```typescript
import mongoose from 'mongoose';

const MONGODB_URI = process.env.MONGODB_URI;

if (!MONGODB_URI) {
  throw new Error('Please define the MONGODB_URI environment variable');
}

let cached = global.mongoose;

if (!cached) {
  cached = global.mongoose = { conn: null, promise: null };
}

export async function connectDB() {
  if (cached.conn) {
    return cached.conn;
  }

  if (!cached.promise) {
    const opts = {
      bufferCommands: false,
    };
    cached.promise = mongoose.connect(MONGODB_URI!, opts).then((mongoose) => {
      return mongoose;
    });
  }
  cached.conn = await cached.promise;
  return cached.conn;
}
```

---

## Step 4: Create Mongoose Models (if using Mongoose)

### Create `frontend/models/User.ts`

```typescript
import mongoose, { Schema, Document } from 'mongoose';

export interface IUser extends Document {
  email: string;
  name: string;
  rollNo: string;
  department: string;
  semester: number;
  createdAt: Date;
  updatedAt: Date;
}

const userSchema = new Schema<IUser>(
  {
    email: { type: String, required: true, unique: true },
    name: { type: String, required: true },
    rollNo: { type: String, required: true, unique: true },
    department: { type: String, required: true },
    semester: { type: Number, required: true },
  },
  { timestamps: true }
);

export default mongoose.models.User || mongoose.model('User', userSchema);
```

### Create `frontend/models/Class.ts`

```typescript
import mongoose, { Schema, Document } from 'mongoose';

export interface IClass extends Document {
  name: string;
  code: string;
  instructor: string;
  schedule: {
    day: string;
    startTime: string;
    endTime: string;
    room: string;
  }[];
  semester: number;
  createdAt: Date;
  updatedAt: Date;
}

const classSchema = new Schema<IClass>(
  {
    name: { type: String, required: true },
    code: { type: String, required: true, unique: true },
    instructor: { type: String, required: true },
    schedule: [
      {
        day: String,
        startTime: String,
        endTime: String,
        room: String,
      },
    ],
    semester: { type: Number, required: true },
  },
  { timestamps: true }
);

export default mongoose.models.Class || mongoose.model('Class', classSchema);
```

### Create `frontend/models/Assignment.ts`

```typescript
import mongoose, { Schema, Document } from 'mongoose';

export interface IAssignment extends Document {
  title: string;
  description: string;
  classId: mongoose.Types.ObjectId;
  dueDate: Date;
  marks: number;
  createdAt: Date;
  updatedAt: Date;
}

const assignmentSchema = new Schema<IAssignment>(
  {
    title: { type: String, required: true },
    description: { type: String },
    classId: { type: Schema.Types.ObjectId, ref: 'Class', required: true },
    dueDate: { type: Date, required: true },
    marks: { type: Number, default: 100 },
  },
  { timestamps: true }
);

export default mongoose.models.Assignment || mongoose.model('Assignment', assignmentSchema);
```

---

## Step 5: Create API Routes

### Create `frontend/app/api/users/route.ts` (GET and POST)

```typescript
import { connectDB } from '@/lib/mongodb';
import User from '@/models/User';
import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  try {
    await connectDB();
    const users = await User.find({}).limit(10);
    return NextResponse.json({ success: true, data: users });
  } catch (error) {
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Unknown error' },
      { status: 500 }
    );
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
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Unknown error' },
      { status: 400 }
    );
  }
}
```

### Create `frontend/app/api/classes/route.ts`

```typescript
import { connectDB } from '@/lib/mongodb';
import Class from '@/models/Class';
import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  try {
    await connectDB();
    const classes = await Class.find({});
    return NextResponse.json({ success: true, data: classes });
  } catch (error) {
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Unknown error' },
      { status: 500 }
    );
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
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Unknown error' },
      { status: 400 }
    );
  }
}
```

---

## Step 6: Test MongoDB Connection

### Create a test API endpoint `frontend/app/api/test-db/route.ts`

```typescript
import { connectDB } from '@/lib/mongodb';
import { NextResponse } from 'next/server';

export async function GET() {
  try {
    await connectDB();
    return NextResponse.json(
      { success: true, message: 'Connected to MongoDB successfully!' },
      { status: 200 }
    );
  } catch (error) {
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Connection failed' },
      { status: 500 }
    );
  }
}
```

### Test in browser or curl:

```bash
curl http://localhost:3000/api/test-db
```

Expected response:
```json
{ "success": true, "message": "Connected to MongoDB successfully!" }
```

---

## Step 7: Run Your Application

```bash
cd frontend
npm run dev
```

Your Next.js app will run on `http://localhost:3000`

---

## Step 8: Test CRUD Operations

### Create a User (POST)
```bash
curl -X POST http://localhost:3000/api/users \
  -H "Content-Type: application/json" \
  -d '{
    "email": "student@example.com",
    "name": "John Doe",
    "rollNo": "21CS001",
    "department": "CSE",
    "semester": 3
  }'
```

### Get All Users (GET)
```bash
curl http://localhost:3000/api/users
```

### Create a Class (POST)
```bash
curl -X POST http://localhost:3000/api/classes \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Data Structures",
    "code": "CS201",
    "instructor": "Dr. Smith",
    "semester": 3,
    "schedule": [
      {
        "day": "Monday",
        "startTime": "10:00",
        "endTime": "11:30",
        "room": "A101"
      }
    ]
  }'
```

---

## Troubleshooting

### Error: "MONGODB_URI is not defined"
- Make sure `.env.local` exists in the `frontend` directory
- Verify the connection string is correct

### Error: "MongoNetworkError"
- Check your IP is whitelisted in MongoDB Atlas (should already be done)
- Ensure you have internet connectivity

### Connection Timeout
- Verify the MongoDB cluster is running (check MongoDB Atlas dashboard)
- Wait for the free cluster to finish initializing if newly created

---

## Next Steps

1. ✅ MongoDB Atlas setup complete
2. ✅ Connection configured
3. 📝 Create more models for:
   - Assignments
   - Attendance
   - Grades
   - Notifications
4. 🔌 Build API endpoints for CRUD operations
5. 🎨 Update frontend components to use MongoDB data
6. 🧪 Write tests for API endpoints
7. 🚀 Deploy to production

---

## Security Best Practices

✅ Keep `.env.local` in `.gitignore`
✅ Use environment variables for sensitive data
✅ Validate and sanitize all user inputs
✅ Add authentication to API routes
✅ Use MongoDB role-based access control
✅ Enable MongoDB network access rules

---

## References

- [MongoDB Atlas Documentation](https://docs.mongodb.com/atlas/)
- [Mongoose Documentation](https://mongoosejs.com/)
- [Next.js API Routes](https://nextjs.org/docs/api-routes/introduction)
- [MongoDB Node.js Driver](https://www.mongodb.com/docs/drivers/node/)

---

**Created for Skedio Project**
**MongoDB Atlas Free Tier | Mongoose ORM | Next.js Backend**
