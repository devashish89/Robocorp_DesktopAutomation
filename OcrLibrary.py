import cv2
import pytesseract
import re
import numpy as np
from PIL import Image

def get_value(text, anchor):
    matches = re.search(r"%s\s*(.*)" % anchor, text, re.IGNORECASE)
    return matches.group(1) if matches else None

def read_text_from_image(imagepath, anchor):
    scaleX = 0.6
    scaleY = 0.6
    img_bgr = cv2.imread(imagepath)
    img_bgr = cv2.resize(img_bgr, None, fx= scaleX*3, fy= scaleY*3, interpolation= cv2.INTER_LINEAR)
    img_gray = cv2.cvtColor(img_bgr, cv2.COLOR_BGR2GRAY)
    gray, img_bin = cv2.threshold(img_gray,128,255,cv2.THRESH_BINARY | cv2.THRESH_OTSU)
    gray = cv2.bitwise_not(img_bin)
    kernel = np.ones((2, 1), np.uint8)
    img = cv2.erode(gray, kernel, iterations=1)
    img = cv2.dilate(img, kernel, iterations=1)
    custom_config = r'--oem 3 --psm 6'
    text = pytesseract.image_to_string(img, config=custom_config)
    return get_value(text, anchor)
