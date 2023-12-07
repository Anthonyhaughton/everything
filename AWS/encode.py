import base64

def encode_file_to_base64(file_path):
    with open(file_path, "rb") as file:
        encoded_content = base64.b64encode(file.read()).decode("utf-8")
    return encoded_content

# Replace 'your_document.docx' with the actual path to your DOCX file
docx_file_path = 'C:\pytest\encode.docx'
base64_content = encode_file_to_base64(docx_file_path)

print(base64_content)
