import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Skedio - Student Academic Portal",
  description: "Better way to manage your academics",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        {children}
      </body>
    </html>
  );
}
