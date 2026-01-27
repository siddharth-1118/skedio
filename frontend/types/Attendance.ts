export interface Attendance {
  id: string;
  userId: string;
  courseId: string;
  date: Date;
  status: 'present' | 'absent' | 'late';
  remarks?: string;
  createdAt: Date;
}

export interface AttendanceStats {
  totalClasses: number;
  presentDays: number;
  absentDays: number;
  lateDays: number;
  percentage: number;
}
