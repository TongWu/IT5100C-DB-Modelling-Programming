# Background
- Barg Car is an **online car rent company**, it has several physical offices, each offices has at least **one employee**
	- Cars are parked in **one of the offices**
# Application Description
## Rent Car Progression
1. Customer register their information online via an app.
2. Then they choose a **car model, pickup location (one of the office), start date, number of days to rent**
	1. For **each car model**, the company has a specific **daily rent and fixed deposit price (定金)**. 
3. To make a booking, the customer **have to pay by credit card**
4. After payment, the booking is made with a **unique booking id (primary key)** and the **booking date** is recorded
## Car information
- The company will assign a specific car with a **specific license plate number (primary key)** in a **specific location** for the booking with the **specific booking number (foreign key)**
- If the car is **belongs to the location**, and it is **not damaged**, then the car is **available**
- A car is **rented** if it between start date + number of day the car being rented
- Once the available car is **assigned**, the assigned car is guaranteed to be available at the **pickup location** on the given start date
## Driver
- Given the **booking id**, the customer may also hire a driver. 
- A driver is an employee of Barg Car
- The driver cannot be hired **before the start date** or **after the return date**
- A driver can only be hired for **consecutive days**
## Car Key Pass
- On the start date of the rent, an employee of the company at the pickup location will **pass the key to the customer**
- When the customer returns the car at **any location**, another employee will **receive the key from the customer**
## Report after return a car
- The same employee who receive the key from the customer assess the condition of the car, and **fill in a return report** detailing the possible damage of the car.
- If there is a damage, **a cost** will be calculated up to the **maximum of the deposit**. The remaining deposit will be returned to the customer.

# Database Structure
## Customer Information
- Full Name
- **P: Email Address**
- Phone Number
- (Optional) Age
- (Optional) Date of Birth
- (Optional) Home Address
## Employee Information
- **P: Employee ID**
- Employee Type (Standard or Driver)
- PDVL (For Driver)
- Full Name
- Phone Number
- Location ZIP code
## Booking Information
- *F: Email Address* (from Customer Information)
- *F: Brand*
- *F: Model*
- *F: license plate number* (from specific car information)
- pickup location
- start date
- duration (number of days to rent)
- Credit card number
- booking date
- **P: booking id**
## Car Model
- **P: Brand**
- **P: Model**
- Capacity (include driver)
- Daily Rent Price
- Fixed Deposit Price
## Specific Car Information
- **P: license plate number**
- *F: Brand* (from Car Model)
- *F: Model* (from Car Model)
- Colour
- Produced year
- Car location (one of the office location)
- Damage condition
- rent condition (rented or not)
- assign condition (assigned to a booking or not)
## Booking Driver Information
- **P, F: booking ID** (from Booking Information)
- *F: PDVL* (from employee information)
- Driver hire start date
- Driver hire duration
## Car Key Information
- **P, F: Booking id** (from Booking Information)
- Key pass date
- Key pass location
- Key pass employee
- Key return date
- Key return location
- Key return employee
## Car Report
- **P, F: Booking id** (from booking information)
- *F: Brand* (from Car Model)
- *F: Model* (from Car Model)
- *F: License Plate Number* (from Specific Car Information)
- Damage condition (from specific car information)
- Damage cost
