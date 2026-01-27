export interface Timetable {
  id: string;
  userId: string;
  courseId: string;
  day: string;
  startTime: string;
  endTime: string;
  room: string;
  faculty: string;
  createdAt: Date;
  updatedAt: Date;
}
