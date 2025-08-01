#section1
students = [
    ["Ravi", [85, 72, 90]],
    ["Sneha", [95, 88, 92]],
    ["Kabir", [65, 70, 60]],
    ["Anita", [75, 80, 78]]
]
print("Ravi's second mark:", students[0][1][1])

for name, marks in students:
    avg = sum(marks) / len(marks)
    print(f"{name}: Average = {avg}")

print("Students scoring >80 in all subjects:")
for name, marks in students:
    if all(m > 80 for m in marks):
        print(name)

name_avg = [[name, sum(marks)/len(marks)] for name, marks in students]
print("List of [name, average]:", name_avg)

#section2
data = {
    "products": ["Mobile", "Laptop", "Tablet", "Camera"],
    "prices": [12000, 55000, 18000, 25000],
    "ratings": [4.5, 4.7, 4.0, 4.2]
}
products_list = [{"name": data["products"][i], "price": data["prices"][i], "rating": data["ratings"][i]} for i in range(len(data["products"]))]
print("Product dictionaries:", products_list)

filtered = [p for p in products_list if p['price'] > 20000 and p['rating'] >= 4.5]
print("Filtered products:", filtered)

sorted_products = sorted(products_list, key=lambda x: x['rating'], reverse=True)
print("Sorted by rating:", sorted_products)

#section3
text = "ai is the future and ai will change everything in the ai world"
words = text.split()
freq = {w: words.count(w) for w in words}
print("Word frequencies:", freq)

print("Words appearing more than once:")
for w, count in freq.items():
    if count > 1:
        print(w)

unique_words = sorted(set(words))
print("Unique sorted words:", unique_words)

set1, set2 = set(words), {"ai", "ml", "data", "future"}
print("Common words:", set1 & set2)

#section4
sales = {'Amit': 70000, 'Sneha': 45000, 'Ravi': 30000, 'Anita': 90000, 'Kabir': 20000}
with_bonus = {k: v * 1.1 for k, v in sales.items()}
print("With 10% bonus:", with_bonus)

high_sales = {k: v for k, v in sales.items() if v > 50000}
print("Sales > 50k:", high_sales)

labels = {k: ('High' if v >= 75000 else 'Medium' if v >= 40000 else 'Low') for k, v in sales.items()}
print("Labels:", labels)

#section5
names, marks = ("Ravi", "Sneha", "Kabir"), (88, 92, 76)
marks_dict = dict(zip(names, marks))
print("Name→Mark dictionary:", marks_dict)

print("Min mark:", min(marks), "Max mark:", max(marks))

marks_set = set(marks)
marks_set.add(85)
print("Marks set after adding 85:", marks_set)

set_a, set_b = {1,2,3}, {3,4,5}
print("Merged unique elements:", set_a | set_b)

#bonus
employees = {
    "E101": {"name": "Ravi", "dept": "Sales", "salary": 50000},
    "E102": {"name": "Sneha", "dept": "Engineering", "salary": 80000},
    "E103": {"name": "Kabir", "dept": "HR", "salary": 45000}
}
employees["E104"] = {"name": "Anita", "dept": "Engineering", "salary": 90000}
for e in employees.values():
    if e['dept'] == "Engineering":
        e['salary'] *= 1.1

from collections import defaultdict
dept_salaries = defaultdict(list)
for e in employees.values():
    dept_salaries[e['dept']].append(e['salary'])
avg_salaries = {d: sum(s)/len(s) for d, s in dept_salaries.items()}
highest_dept = max(avg_salaries, key=avg_salaries.get)
print("After updates:", employees)
print("Department with highest avg salary:", highest_dept)
