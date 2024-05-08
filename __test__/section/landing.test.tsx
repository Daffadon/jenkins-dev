import Home from "@/app/page";
import { render, screen } from "@testing-library/react";
import { expect, test } from "vitest";

test("About Section", () => {
  render(<Home />);
  expect(
    screen.getByRole("heading", { level: 2, name: /Learn/i })
  ).toBeDefined();
  expect(screen.getByText(/Instantly deploy your Next.js site to a shareable URL with Vercel./)).toBeDefined();
});