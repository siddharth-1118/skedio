export interface Marks {
  id: string;
  userId: string;
  courseId: string;
  assessmentType: string;
  marksObtained: number;
  totalMarks: number;
  percentage: number;
  grade: string;
  date: Date;
  createdAt: Date;
}
