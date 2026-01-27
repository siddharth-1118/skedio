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
