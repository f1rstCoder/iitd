from flask import Flask
from flask import request
import pymysql
import pandas as pd
import json
global test_list

app = Flask(__name__)

app.secret_key = 'any random string'

UPLOAD_FOLDER = 'static/'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def dbConnection():
    try:
        connection = pymysql.connect(host="localhost", user="root", password="root", database="disable")
        return connection
    except:
        print("Something went wrong in database Connection")

def dbClose():
    try:
        dbConnection().close()
    except:
        print("Something went wrong in Close DB Connection")

con = dbConnection()
cursor = con.cursor()

# matchthefollow=5
# fillinblanks=2
# mcqlevel=6

"########################################################################################"     

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        
        #getting the response data
        request_data = request.data 
        #converting it from json to key value pair
        request_data = json.loads(request_data.decode('utf-8'))
        
        fname = request_data['fname']
        lname = request_data['lname']
        email = request_data['email']
        password = request_data['password']
        phone = request_data['phone']
        age = request_data['age']
        
        cursor.execute('SELECT * FROM register WHERE email = %s', (email))
        count = cursor.rowcount
        if count == 0: 
            sql1 = "INSERT INTO register(fname, lname,email, password, phone,age) VALUES (%s, %s, %s, %s, %s, %s);"
            val1 = (fname, lname,email, password, phone,age)
            cursor.execute(sql1,val1)
            con.commit()    
            
            sql11 = "INSERT INTO levelofuser(username,email,levelofuser) VALUES (%s, %s, %s);"
            val11 = (fname, email,"Level 1")
            cursor.execute(sql11,val11)
            con.commit()
            
            return "success" 
        else:               
            return "fail"   

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == "POST":
        
        #getting the response data
        request_data = request.data 
        #converting it from json to key value pair
        request_data = json.loads(request_data.decode('utf-8'))
        
        fname = request_data['fname']
        password = request_data['pass']
        print(fname)
        print(password)
        
        cursor.execute('SELECT * FROM register WHERE fname = %s AND password = %s', (fname, password))
        count = cursor.rowcount
        print(count)
        if count > 0:
            row = cursor.fetchone() 
            newlst=list(row)
            
            cursor.execute('SELECT levelofuser FROM levelofuser WHERE email = %s', (row[2]))
            level = cursor.fetchone()
            
            newlst.append(level[0])
            
            jsonObj = json.dumps(newlst)
            print(jsonObj)
            
            return jsonObj
        else:
            return "fail"
        
"########################################################################################"  


@app.route('/getVideos/<level>', methods=['GET', 'POST'])
def getVideos(level):
        
    cursor.execute('SELECT * FROM videos WHERE level=%s',(level))
    row = cursor.fetchall() 
    
    jsonObj = json.dumps(row)
    # print(jsonObj)
    
    return jsonObj

@app.route('/getProfile/<username>', methods=['GET', 'POST'])
def getProfile(username):
        
    cursor.execute('SELECT * FROM register WHERE fname = %s', (username))
    row = cursor.fetchall() 
    
    jsonObj = json.dumps(row)
    print(jsonObj)
    
    return jsonObj

@app.route('/getMcqQues/<level>', methods=['GET', 'POST'])
def getMcqQues(level):
        
    cursor.execute('SELECT * FROM mcqtable WHERE level=%s',(level))
    row = cursor.fetchall() 
    
    jsonObj = json.dumps(row)
    # print(jsonObj)
    
    return jsonObj

@app.route('/getFillQues/<level>', methods=['GET', 'POST'])
def getFillQues(level):
        
    cursor.execute('SELECT * FROM fillinblanks WHERE level=%s',(level))
    row = cursor.fetchall() 
    
    jsonObj = json.dumps(row)
    # print(jsonObj)
    
    return jsonObj

"########################################################################################" 

@app.route('/updateVideoLevel', methods=['GET', 'POST'])
def updateVideoLevel():
    if request.method == "POST":
        
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8'))
        
        idofvideo = request_data['id']
        level = request_data['level']
        username = request_data['username']
        email = request_data['email']       
            
        sql1 = "UPDATE levelofuser SET "+idofvideo+" = 1 WHERE username=%s AND email=%s"
        val1 = (username,email)
        cursor.execute(sql1,val1)
        con.commit()
        
        cursor.execute('SELECT * FROM levelofuser WHERE username=%s AND email=%s',(username,email))
        row = cursor.fetchone()
        
        # 
        if level == 'Level 1' or level == 'Level 2':
            matchthefollow=6            
            cursor.execute('SELECT * FROM fillinblanks WHERE level=%s',(level))
            fillinblanks = cursor.rowcount 
        else:
            matchthefollow=1
            fillinblanks=1  
            
        cursor.execute('SELECT * FROM mcqtable WHERE level=%s',(level))
        mcqlevel = cursor.rowcount
        
        print()
        print(matchthefollow)
        print(fillinblanks)
        print(mcqlevel)
        print()
        
        if 0 not in row and row[-3] == matchthefollow and row[-2] == fillinblanks and row[-1] == mcqlevel:
            lel = "Level "+str(int(row[2].split(" ")[1])+1)
            if lel == 'Level 1' or lel == 'Level 2':            
                sql1 = "UPDATE levelofuser SET levelofuser=%s,video1=%s,video2=%s,video3=%s,video4=%s,video5=%s,video6=%s,video7=%s,video8=%s,video9=%s,video10=%s,video11=%s,video12=%s,video13=%s,video14=%s,video15=%s,matchthefollow=%s,fillinblanks=%s,mcq=%s WHERE username=%s AND email=%s"
                val1 = ("Level "+str(int(row[2].split(" ")[1])+1),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,username,email)
                cursor.execute(sql1,val1)
                con.commit()
            else:
                sql1 = "UPDATE levelofuser SET levelofuser=%s,video1=%s,video2=%s,video3=%s,video4=%s,video5=%s,video6=%s,video7=%s,video8=%s,video9=%s,video10=%s,video11=%s,video12=%s,video13=%s,video14=%s,video15=%s,matchthefollow=%s,fillinblanks=%s,mcq=%s WHERE username=%s AND email=%s"
                val1 = ("Level "+str(int(row[2].split(" ")[1])+1),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,username,email)
                cursor.execute(sql1,val1)
                con.commit()
            
            return "levelpassed"
        else:                    
            return "success" 
        
@app.route('/updateMatchLevel', methods=['GET', 'POST'])
def updateMatchLevel():
    if request.method == "POST":
        
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8'))
        
        score = request_data['score']
        username = request_data['username']
        email = request_data['email'] 
        level = request_data['level']    
            
        sql1 = "UPDATE levelofuser SET matchthefollow = %s WHERE username=%s AND email=%s"
        val1 = (score,username,email)
        cursor.execute(sql1,val1)
        con.commit()
        
        cursor.execute('SELECT * FROM levelofuser WHERE username=%s AND email=%s',(username,email))
        row = cursor.fetchone()
        
        if level == 'Level 1' or level == 'Level 2':
            matchthefollow=6            
            cursor.execute('SELECT * FROM fillinblanks WHERE level=%s',(level))
            fillinblanks = cursor.rowcount 
        else:
            matchthefollow=1
            fillinblanks=1  
            
        cursor.execute('SELECT * FROM mcqtable WHERE level=%s',(level))
        mcqlevel = cursor.rowcount
        
        print()        
        print(level)
        print(matchthefollow)
        print(fillinblanks)
        print(mcqlevel)
        print()
        
        if 0 not in row and row[-3] == matchthefollow and row[-2] == fillinblanks and row[-1] == mcqlevel:
            lel = "Level "+str(int(row[2].split(" ")[1])+1)
            if lel == 'Level 1' or lel == 'Level 2':            
                sql1 = "UPDATE levelofuser SET levelofuser=%s,video1=%s,video2=%s,video3=%s,video4=%s,video5=%s,video6=%s,video7=%s,video8=%s,video9=%s,video10=%s,video11=%s,video12=%s,video13=%s,video14=%s,video15=%s,matchthefollow=%s,fillinblanks=%s,mcq=%s WHERE username=%s AND email=%s"
                val1 = ("Level "+str(int(row[2].split(" ")[1])+1),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,username,email)
                cursor.execute(sql1,val1)
                con.commit()
            else:
                sql1 = "UPDATE levelofuser SET levelofuser=%s,video1=%s,video2=%s,video3=%s,video4=%s,video5=%s,video6=%s,video7=%s,video8=%s,video9=%s,video10=%s,video11=%s,video12=%s,video13=%s,video14=%s,video15=%s,matchthefollow=%s,fillinblanks=%s,mcq=%s WHERE username=%s AND email=%s"
                val1 = ("Level "+str(int(row[2].split(" ")[1])+1),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,username,email)
                cursor.execute(sql1,val1)
                con.commit()
            
            return "levelpassed"
        else:                    
            return "success" 
        
@app.route('/updateMCQLevel', methods=['GET', 'POST'])
def updateMCQLevel():
    if request.method == "POST":
        
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8'))
        
        score = request_data['score']
        username = request_data['username']
        email = request_data['email'] 
        level = request_data['level']       
            
        sql1 = "UPDATE levelofuser SET mcq = %s WHERE username=%s AND email=%s"
        val1 = (score,username,email)
        cursor.execute(sql1,val1)
        con.commit()
        
        cursor.execute('SELECT * FROM levelofuser WHERE username=%s AND email=%s',(username,email))
        row = cursor.fetchone()
        
        if level == 'Level 1' or level == 'Level 2':
            matchthefollow=6            
            cursor.execute('SELECT * FROM fillinblanks WHERE level=%s',(level))
            fillinblanks = cursor.rowcount 
        else:
            matchthefollow=1
            fillinblanks=1  
            
        cursor.execute('SELECT * FROM mcqtable WHERE level=%s',(level))
        mcqlevel = cursor.rowcount
        
        print(row)
        print(matchthefollow)
        print(fillinblanks)
        print(mcqlevel)
        print()
        
        if 0 not in row and row[-3] == matchthefollow and row[-2] == fillinblanks and row[-1] == mcqlevel:
            lel = "Level "+str(int(row[2].split(" ")[1])+1)
            if lel == 'Level 1' or lel == 'Level 2':            
                sql1 = "UPDATE levelofuser SET levelofuser=%s,video1=%s,video2=%s,video3=%s,video4=%s,video5=%s,video6=%s,video7=%s,video8=%s,video9=%s,video10=%s,video11=%s,video12=%s,video13=%s,video14=%s,video15=%s,matchthefollow=%s,fillinblanks=%s,mcq=%s WHERE username=%s AND email=%s"
                val1 = ("Level "+str(int(row[2].split(" ")[1])+1),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,username,email)
                cursor.execute(sql1,val1)
                con.commit()
            else:
                sql1 = "UPDATE levelofuser SET levelofuser=%s,video1=%s,video2=%s,video3=%s,video4=%s,video5=%s,video6=%s,video7=%s,video8=%s,video9=%s,video10=%s,video11=%s,video12=%s,video13=%s,video14=%s,video15=%s,matchthefollow=%s,fillinblanks=%s,mcq=%s WHERE username=%s AND email=%s"
                val1 = ("Level "+str(int(row[2].split(" ")[1])+1),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,username,email)
                cursor.execute(sql1,val1)
                con.commit()
            
            return "levelpassed"
        else:                    
            return "success" 
        
@app.route('/updateFillLevel', methods=['GET', 'POST'])
def updateFillLevel():
    if request.method == "POST":
        
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8'))
        
        score = request_data['score']
        username = request_data['username']
        email = request_data['email']
        level = request_data['level']
            
        sql1 = "UPDATE levelofuser SET fillinblanks = %s WHERE username=%s AND email=%s"
        val1 = (score,username,email)
        cursor.execute(sql1,val1)
        con.commit()
        
        cursor.execute('SELECT * FROM levelofuser WHERE username=%s AND email=%s',(username,email))
        row = cursor.fetchone()
        
        if level == 'Level 1' or level == 'Level 2':
            matchthefollow=6            
            cursor.execute('SELECT * FROM fillinblanks WHERE level=%s',(level))
            fillinblanks = cursor.rowcount 
        else:
            matchthefollow=1
            fillinblanks=1  
            
        cursor.execute('SELECT * FROM mcqtable WHERE level=%s',(level))
        mcqlevel = cursor.rowcount
        
        print()
        print(matchthefollow)
        print(fillinblanks)
        print(mcqlevel)
        print()
        
        if 0 not in row and row[-3] == matchthefollow and row[-2] == fillinblanks and row[-1] == mcqlevel:
            lel = "Level "+str(int(row[2].split(" ")[1])+1)
            if lel == 'Level 1' or lel == 'Level 2':            
                sql1 = "UPDATE levelofuser SET levelofuser=%s,video1=%s,video2=%s,video3=%s,video4=%s,video5=%s,video6=%s,video7=%s,video8=%s,video9=%s,video10=%s,video11=%s,video12=%s,video13=%s,video14=%s,video15=%s,matchthefollow=%s,fillinblanks=%s,mcq=%s WHERE username=%s AND email=%s"
                val1 = ("Level "+str(int(row[2].split(" ")[1])+1),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,username,email)
                cursor.execute(sql1,val1)
                con.commit()
            else:
                sql1 = "UPDATE levelofuser SET levelofuser=%s,video1=%s,video2=%s,video3=%s,video4=%s,video5=%s,video6=%s,video7=%s,video8=%s,video9=%s,video10=%s,video11=%s,video12=%s,video13=%s,video14=%s,video15=%s,matchthefollow=%s,fillinblanks=%s,mcq=%s WHERE username=%s AND email=%s"
                val1 = ("Level "+str(int(row[2].split(" ")[1])+1),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,username,email)
                cursor.execute(sql1,val1)
                con.commit()
            
            return "levelpassed"
        else:                    
            return "success" 
        
"########################################################################################"
        
@app.route('/getUserLevel', methods=['GET', 'POST'])
def getUserLevel():
    if request.method == "POST":
        
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8'))
        
        email = request_data['email']
        
        cursor.execute('SELECT levelofuser FROM levelofuser WHERE email = %s', (email))
        level = cursor.fetchone()
        
        return str(level[0])
    
"########################################################################################"

@app.route('/getunseenvideos', methods=['GET', 'POST'])
def getunseenvideos():
    if request.method == "POST":
        
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8'))
        
        email = request_data['email']
        
        cursor.execute('SELECT video1,video2,video3,video4,video5,video6,video7,video8,video9,video10,video11,video12,video13,video14,video15 FROM levelofuser WHERE email = %s', (email))
        level = cursor.fetchone()
        df = pd.DataFrame([level])
        col=['video1', 'video2', 'video3', 'video4', 'video5', 'video6', 'video7', 'video8', 'video9', 'video10', 'video11', 'video12', 'video13', 'video14', 'video15']
        df.columns =col
        new_lst=[col[i] for i, c in enumerate(df.columns) if 0 in df[c].values]
        text = ','.join(new_lst)
        
        print(text)
        
        return "The unseen videos are : "+str(text)
    
if __name__ == "__main__":
    app.run("0.0.0.0")