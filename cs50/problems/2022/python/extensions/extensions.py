file = str(input("Filename: ")).lower()

exten = {
     ".gif": "image/gif",
     ".jpg": "image/jpeg",
     ".jpeg": "image/jpeg",
     ".png": "image/png",
     ".pdf": "application/pdf",
     ".txt": "text/plain",
     ".zip": "application/zip"
}

# We can use for "x" "in" ___ to filter out any user input other than what we are looking for.
# ex: hdfsjbfsbdf.pdf < this code will only see that that file contains ".pdf"

if ".jpg" in file or "jpeg" in file:
     print(exten[".jpg"])

elif ".png" in file:
     print(exten[".png"])

elif ".pdf" in file:
     print(exten[".pdf"])

elif ".txt" in file:
     print(exten[".txt"])

elif ".zip" in file:
     print(exten[".zip"])

elif ".gif" in file:
     print(exten[".gif"])

else:
     print("application/octet-stream")

