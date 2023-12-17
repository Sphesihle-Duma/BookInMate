#!/usr/bin/python3
"""Frontend entry point for booking app"""
from flask import Flask, render_template, request, url_for, redirect, flash, session
import requests

app = Flask(__name__, static_url_path='/static')
app.config['SECRET_KEY'] = 'f9a5715d1cdf9bfa442cba7b27084332154ebf1a4598ae44'
time_slots = ["09:00", "10:00", "11:00", "12:00", "13:00", "14:00"]

@app.route('/')
def index():
    """view function that renders the home page"""
    app.logger.info('Loading the home page')
    return render_template('index.html')

@app.route('/about')
def about_us():
    """view function that render the about page"""
    app.logger.info('Loading the about us page')
    return render_template('about.html')
    
@app.route('/create_a_booking', methods=('GET', 'POST'))
def create_a_booking():
    """view function for making a booking"""
    facilities_res = requests.get("http://127.0.01:5001/api/facilities")
    if facilities_res.status_code == 200:
        facilities = facilities_res.json()
    if request.method == 'POST':
        url = 'http://127.0.0.1:5001/api/booking'
        booking_data={'inmate_id': request.form['InMateId'],
                      'visitor_id': request.form['visitorID'],
                      'date': request.form['dateInput'],
                      'timeslot': request.form['timeInput'],
                      'name': request.form['firstname'],
                      'facility_id': request.form['facilityInput'],
                      'email': request.form['emailInput']
        }
        response = requests.post(url, json=booking_data)
        if response.status_code == 201:
            app.logger.info("Booking created successfully!")
            flash("Thank you, we have recieved your request")
            return redirect(url_for('index'))
        else:
            app.logger.debug(f"Error:{response.status_code}\n{response.text}")
            error_message = response.json().get('error', 'An error occurred during booking.')
            if 'Duplicate entry' in error_message:
                flash("Booking failed: A booking already exists for this inmate and visitor.")
            else:
                flash(f"Booking failed: {error_message}", 'error')

       
        
    app.logger.info("Load a booking page")
    return render_template('create_a_booking.html', time_slots=time_slots, facilities=facilities)

@app.route('/visiting_hours')
def visiting_process():
    """view function that renders visiting hours page"""
    app.logger.info('Loading the visiting hours page')
    return render_template('visiting_process.html')

@app.route('/findInmate')
def find_in_mate():
    """veiw function for find inmate page"""
    app.logger.info('loading the find inMate')
    return render_template('findInMate.html')

@app.route('/admin', methods=('GET','POST'))
def admin():
    """view function for admin dashboard"""
    response = requests.get("http://127.0.0.1:5001/api/all_bookings")
    if response.status_code == 200:
        bookings = response.json()
    login = False
    if request.method == 'POST':
        if(request.form['username'] != "admin"):
            flash("Invalid username")
        elif(request.form['password'] != "admin"):
            flash("Incorrect password")
        else:
            login = True
    app.logger.info('Loading admin dashboard')
    return render_template('admin.html', bookings=bookings, login=login)
if __name__ == '__main__':
    app.run(debug=True)
