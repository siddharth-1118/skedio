export interface Grade {
  id: string;
  userId: string;
  courseId: string;
  grade: string;
  gradePoint: number;
  creditPoints: number;
  semester: number;
  academicYear: string;
  createdAt: Date;
}

export interface GradeScale {
  grade: string;
  minPercentage: number;
  maxPercentage: number;
  gradePoint: number;
}
