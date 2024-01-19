import cv2

FILTERED_IMAGE_SIZE = 128


# Cat recognition form Camera
cap = cv2.VideoCapture(0)


def filter_image(image):
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    return cv2.resize(gray, (FILTERED_IMAGE_SIZE, FILTERED_IMAGE_SIZE))

while 1:  
    ret, img = cap.read()  
    filtered = filter_image(img)
    
#    for (x,y,w,h) in faces:  
#        cv2.rectangle(img,(x,y),(x+w,y+h),(255,255,0),2)  
#        roi_gray = gray[y:y+h, x:x+w]  
#        roi_color = img[y:y+h, x:x+w]  
  
    cv2.imshow('img',img)  
    cv2.imshow('img_filter',filtered)  

#ESCAPE  
#ESCAPE  
#ESCAPE  
    k = cv2.waitKey(30) & 0xff
    if k == 27:  
        break
cap.release()  
cv2.destroyAllWindows()
#ESCAPE  
#ESCAPE  
#ESCAPE  
  

