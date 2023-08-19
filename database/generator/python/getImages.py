import os
import requests
import re
from urllib.parse import urlparse
from unidecode import unidecode 

def clean_filename(filename):
    cleaned = unidecode(filename).lower() 
    cleaned = re.sub(r'[^\w\s.-]', '', cleaned) 
    return cleaned

def get_extension_from_url(url):
    parsed_url = urlparse(url)
    path = parsed_url.path
    filename = os.path.basename(path)
    filename_parts = filename.split('.')
    if len(filename_parts) > 1:
        return filename_parts[-1].split('?')[0]
    return None

def download_images(image_data, output_folder):
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    for name, url in image_data:
        response = requests.get(url)
        
        if response.status_code == 200:
            image_extension = get_extension_from_url(url)
            cleaned_name = clean_filename(name)
            if image_extension == 'webp':
                image_extension = 'jpg'
            image_filename = f"{cleaned_name}.{image_extension}" if image_extension else f"{cleaned_name}.jpg"
            image_path = os.path.join(output_folder, image_filename)
            
            with open(image_path, "wb") as image_file:
                image_file.write(response.content)
            print(f"Downloaded: {image_filename}")
        else:
            print(f"Failed to download: {url}")

if __name__ == "__main__":
    image_data = [
        ("Azulejo", "https://http2.mlstatic.com/D_NQ_NP_765031-MLM41826773869_052020-O.webp"),
        ("Bidé", "https://cdn.drouot.com/d/image/lot?size=fullHD&path=1625/130467/f6d10ed71562dbed5b134f36dbdad844"),
        ("Cacerola", "https://m.media-amazon.com/images/I/61Iju-mV34S.__AC_SX300_SY300_QL70_ML2_.jpg"),
        ("Candelabro", "https://www.flordepina.mx/cdn/shop/products/1_bf436cf2-b2af-47b2-b1d2-334dfc7a3871_1000x.jpg?v=1592153632"),
        ("Cuenco", "https://m.media-amazon.com/images/I/61op6gpN2cL.__AC_SX300_SY300_QL70_ML2_.jpg"),
        ("Ensaladera", "https://m.media-amazon.com/images/I/71qZCt5YbML._AC_SX522_.jpg"),
        ("Florero", "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRlcAtyL1j_Qb0GtfTb_-rh6VvrYrPxE_9iZMd2AOYIVWQ_3mLrRflvLadSDcdT0AIyjYp2UV-Ku4RrwSFUTjQKyxPggd5u&usqp=CAY"),
        ("Fregadero", "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQwTH_cMRKJNzMpeCyF02dp2nh6adbm503cBOtwZNyc0MDc4as56IQspezleoI-lvHiictpqCMssibH1cm5kW6aj-iL0mufU_8oa7LdyE_AkVhjb3vuF_Zl&usqp=CAE"),
        ("Inodoro", "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTfQtPpFBpBrT5Dxp1lS3yOBX1jPneCfKG7wCXsivB9bFmj8QI57M2Q7cgce9PNFTOjGbWWQAcKO8nmHVcDe9TZdTBLWrO4i2Vrh43rtrbUuXtBEWG2mhSPmSY&usqp=CAE"),
        ("Jarra", "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRzvg-QODrYxtR4Ne9RUNSu8MJTumGqs4C8-EpRUHn9TsuBj15OeieKJBejOm_DyyMP2j5LLamlrOZLuAoZydl7YBo3gt7XLEGiB1h9rmOHJ2MWDJJRBn5awA&usqp=CAE"),
        ("Jarrón", "https://m.media-amazon.com/images/I/61QaT6c9prL._AC_SX522_.jpg"),
        ("Ladrillo", "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQ0iQt_2QJnvuwZe8i-mJAZoCpYn94slysEI76Z1APV6aOaJc75IUmuyVv6GsSR1x6XD0SkF4dWWyGgzyZ_on8JvjNEVcdL2e-2F7vC6YAiq39u5dHj94xUltY&usqp=CAE"),
        ("Lavabo", "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRSTemCZGxs0HgV3aLHE7iF51RDy0riV28Eqrv8TDJIYvCOTHjJ6FxB_5nzIGdiZFCKlTM0m5CFLlh4MLCtuehSIHEBt6NDItgBg2uhGN3RCxG-7aUB70rP&usqp=CAE"),
        ("Maceta", "https://m.media-amazon.com/images/I/81gTfyTrH7L._AC_SX522_.jpg"),
        ("Mosaico", "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSBOHdecHBtZz6pEoP2C4-lvbVTTlLwGOzVC8N4eV6-_yX8WHPPqKGRinraYzs6TWNpM-rROUf1anX3OlFv_8TyIwt_rqKd&usqp=CAE"),
        ("Pimentero", "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQM6wNPnBPHUZzwlwjdcTHpEOae8ufvWy86tvtdodQ0ZofZWN3gfOeqHjwO8xrqkPsWU9lR3BhPU-AslGS5XPyQAkStWFdrqwsLtDhaQb8&usqp=CAE"),
        ("Platillo", "https://m.media-amazon.com/images/I/61WUSN9sHnS._AC_SX522_.jpg"),
        ("Plato", "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQsCA2POixRZJw0ZTGJ9dKGBfsxqWGOFa284ktadt6NzthkqA0dXlpu2R1z-94k8-kIrx5mVNkVkptpu7eHUciCftzGKKqHmLgT4-_UtqX3de5HQMGPO8XY7A&usqp=CAE"),
        ("Salero", "https://m.media-amazon.com/images/I/71kUK-zH5yL.__AC_SX300_SY300_QL70_ML2_.jpg"),
        ("Taza", "https://m.media-amazon.com/images/I/71AAWtpWPWS.__AC_SX300_SY300_QL70_ML2_.jpg"),
        ("Tazón", "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQ2nXtRqRohAoWRqwZ2HDmMcJIAiNCVOWGQ3LPAAd9m_gr-_QqSAucCE-0Mp-sOH9-F2uPzq0UprkBBRVk5sjrsx_M9FRjS7Q&usqp=CAY"),
        ("Tetera", "https://m.media-amazon.com/images/I/81FfW1zT+pL._AC_SX300_SY300_.jpg"),
        ("Vaso", "https://http2.mlstatic.com/D_NQ_NP_972138-MLM53060988460_122022-O.webp"),
    ]
    output_folder = "downloaded_images"
    
    download_images(image_data, output_folder)
