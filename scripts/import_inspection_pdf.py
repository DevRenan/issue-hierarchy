import sys
import os
import json
import fitz  # PyMuPDF

def extract_issues(pdf_path, output_dir):
    doc = fitz.open(pdf_path)
    issues = []
    os.makedirs(output_dir, exist_ok=True)
    issue_idx = 1

    for page in doc:
        blocks = page.get_text("blocks")
        images = page.get_images(full=True)
        img_objs = []
        for img_index, img in enumerate(images):
            xref = img[0]
            pix = fitz.Pixmap(doc, xref)
            img_path = os.path.join(output_dir, f"issue_{issue_idx}.jpg")
            if pix.n > 4:
                pix = fitz.Pixmap(fitz.csRGB, pix)
            pix.save(img_path)
            img_objs.append({"img_path": img_path, "bbox": pix.irect})
            pix = None
            issue_idx += 1

        # Heuristic: for each block, if it matches the pattern, associate with nearest image
        for block in blocks:
            text = block[4].strip()
            if not text:
                continue
            # Simple pattern: location, description, (number)
            lines = [l.strip() for l in text.split('\n') if l.strip()]
            if len(lines) < 2:
                continue
            location = lines[0]
            description = lines[1]
            issue_number = None
            for l in lines:
                if l.startswith('(') and l.endswith(')'):
                    try:
                        issue_number = int(l[1:-1])
                    except:
                        pass
            # Find nearest image (by y coordinate)
            img_path = None
            if img_objs:
                img_path = img_objs.pop(0)["img_path"]
            issues.append({
                "location": location,
                "description": description,
                "issue_number": issue_number,
                "image_path": img_path
            })
    return issues

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python import_inspection_pdf.py <pdf_path>")
        sys.exit(1)
    pdf_path = sys.argv[1]
    output_dir = "tmp/imports"
    issues = extract_issues(pdf_path, output_dir)
    print(json.dumps(issues, ensure_ascii=False, indent=2))

