import datetime
import random

def calculate_customer_total(initial_premium, annual_increase, years):
    """
    Calculates the total premium paid by a single customer over a set duration.
    Formula: Total = Sum of (Premium * (1 + increase)^year)
    """
    total_paid = 0
    current_premium = initial_premium
    
    for year in range(years):
        total_paid += current_premium
        # Increase the premium for the next year
        current_premium *= (1 + annual_increase)
        
    return total_paid

def run_simulation():
    # Constants based on Guidelines
    NUM_CUSTOMERS = 5000
    DURATION_YEARS = 15
    
    # Policy Data
    STANDARD_INIT = 10000
    STANDARD_INC = 0.05
    PREMIUM_INIT = 20000
    PREMIUM_INC = 0.08
    
    customer_totals = []

    # Process each customer independently
    for i in range(NUM_CUSTOMERS):
        # Randomly assign a policy type to simulate a real customer base
        policy_type = random.choice(['Standard', 'Premium'])
        
        if policy_type == 'Standard':
            total = calculate_customer_total(STANDARD_INIT, STANDARD_INC, DURATION_YEARS)
        else:
            total = calculate_customer_total(PREMIUM_INIT, PREMIUM_INC, DURATION_YEARS)
            
        customer_totals.append(total)

    # Perform Calculations
    total_collected = sum(customer_totals)
    highest_premium = max(customer_totals)
    lowest_premium = min(customer_totals)
    average_premium = total_collected / NUM_CUSTOMERS

    # Prepare Report Content
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    report_lines = [
        f"Insurance Premium Simulation Report",
        f"Run Date and Time: {timestamp}",
        f"{'-'*40}",
        f"Total Premium Collected:   ₹{total_collected:,.2f}",
        f"Highest Premium Paid:      ₹{highest_premium:,.2f}",
        f"Lowest Premium Paid:       ₹{lowest_premium:,.2f}",
        f"Average Premium per User:  ₹{average_premium:,.2f}",
        f"{'-'*40}"
    ]

    # Write results to file
    file_name = "insurance_premium_report.txt"
    try:
        with open(file_name, "w", encoding="utf-8") as f:
            f.write("\n".join(report_lines))
        print(f"Success: Report generated as '{file_name}'")
    except Exception as e:
        print(f"An error occurred while writing the file: {e}")

    # Display results in Notebook as well
    for line in report_lines:
        print(line)

# Run the program
if __name__ == "__main__":
    run_simulation()