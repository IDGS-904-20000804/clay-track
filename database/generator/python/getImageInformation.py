
import os

def generate_image_info(image_path):
    filename, extension = os.path.splitext(os.path.basename(image_path))
    file_size = os.path.getsize(image_path)
    file_path = os.path.abspath(image_path)
    
    return {
        "FileName": filename,
        "FileExtension": extension.lstrip('.'),
        "FileSizeInBytes": file_size,
        "FilePath": file_path
    }

if __name__ == "__main__":
    directory_path = "./downloaded_images"
    
    image_info_list = []
    
    for filename in os.listdir(directory_path):
        if filename.lower().endswith(('.jpg', '.jpeg', '.png', '.gif')):
            image_path = os.path.join(directory_path, filename)
            image_info = generate_image_info(image_path)
            image_info_list.append(image_info)
    
    output_file_path = "image_info.txt"
    
    with open(output_file_path, "w") as output_file:
        for image_info in image_info_list:
            output_file.write(str(image_info) + "\n")
    
    print(f"Image information saved to {output_file_path}")
