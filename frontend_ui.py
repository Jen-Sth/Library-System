import streamlit as st
import mysql.connector

# Database Connection
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="T0to@Ro123", #Enter the password for the host  
        database="librarysystem",  
        port=3306
    )

# Function to run SQL queries
def run_query(query, params=None, fetch=False):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute(query, params or ())
    data = cursor.fetchall() if fetch else None
    conn.commit()
    cursor.close()
    conn.close()
    return data

# Streamlit UI
st.set_page_config(page_title="Library System", layout="wide")
st.markdown("# 📚 Library Management System")
st.sidebar.image("https://cdn-icons-png.flaticon.com/512/2232/2232688.png", width=150)

# Navigation
menu = st.sidebar.radio("Navigation", ["📖 Books", "👤 Members", "📑 Loans", "💰 Fines", "📝 Reservations"])

if menu == "📖 Books":
    st.markdown("## 📖 Manage Books")
    with st.expander("📋 View Books"):
        books = run_query("SELECT * FROM Books", fetch=True)
        st.dataframe(books)

    col1, col2 = st.columns(2)
    with col1:
        st.subheader("➕ Add Book")
        with st.form("Add Book"):
            title = st.text_input("Title")
            author = st.text_input("Author")
            genre = st.text_input("Genre")
            isbn = st.text_input("ISBN")
            category_id = st.number_input("Category ID", min_value=1)
            publisher_id = st.number_input("Publisher ID", min_value=1)
            submit = st.form_submit_button("Add Book")
            if submit:
                run_query("INSERT INTO Books (Title, Author, Genre, ISBN, CategoryID, PublisherID) VALUES (%s, %s, %s, %s, %s, %s)",
                          (title, author, genre, isbn, category_id, publisher_id))
                st.success("Book Added!")

    with col2:
        st.subheader("❌ Delete Book")
        book_id = st.number_input("Enter Book ID to Delete", min_value=1)
        if st.button("Delete Book", key="delete_book"):
            run_query("DELETE FROM Books WHERE BookID = %s", (book_id,))
            st.success("Book Deleted!")

elif menu == "👤 Members":
    st.markdown("## 👤 Manage Members")
    with st.expander("📋 View Members"):
        members = run_query("SELECT * FROM Members", fetch=True)
        st.dataframe(members)
    
    #Add member
    with st.form("Add Member"):
        name = st.text_input("Name")
        contact = st.text_input("Contact email")
        membership_date = st.date_input("Membership Date")
        submit = st.form_submit_button("Add Member")
        if submit:
            run_query("INSERT INTO Members (Name, Contact, MembershipDate) VALUES (%s, %s, %s)", (name, contact, membership_date))
            st.success("Member Added!")

    # Delete Member
    st.subheader("❌ Delete Member")
    member_id = st.number_input("Enter Member ID to Delete", min_value=1, step=1)
    if st.button("Delete Member"):
        run_query("DELETE FROM Members WHERE MemberID = %s", (member_id,))
        st.success(f"Member with ID {member_id} Deleted!")

elif menu == "📑 Loans":
    st.markdown("## 📑 Manage Loans")
    with st.expander("📋 View Loans"):
        loans = run_query("SELECT * FROM Loans", fetch=True)
        st.dataframe(loans)
    
    with st.form("Issue Book"):
        member_id = st.number_input("Member ID", min_value=1)
        book_id = st.number_input("Book ID", min_value=1)
        issue_date = st.date_input("Issue Date")
        due_date = st.date_input("Due Date")
        submit = st.form_submit_button("Issue Book")
        if submit:
            run_query("INSERT INTO Loans (MemberID, BookID, IssueDate, DueDate) VALUES (%s, %s, %s, %s)", (member_id, book_id, issue_date, due_date))
            st.success("Book Issued!")

elif menu == "💰 Fines":
    st.markdown("## 💰 Manage Fines")
    with st.expander("📋 View Fines"):
        fines = run_query("SELECT * FROM Fines", fetch=True)
        st.dataframe(fines)
    
    fine_id = st.number_input("Fine ID to Mark as Paid", min_value=1)
    if st.button("Mark as Paid"):
        run_query("UPDATE Fines SET PaidStatus = TRUE WHERE FineID = %s", (fine_id,))
        st.success("Fine Marked as Paid!")

elif menu == "📝 Reservations":
    st.markdown("## 📝 Manage Reservations")
    with st.expander("📋 View Reservations"):
        reservations = run_query("SELECT * FROM Reservations", fetch=True)
        st.dataframe(reservations)
    
    with st.form("Add Reservation"):
        book_id = st.number_input("Book ID", min_value=1)
        member_id = st.number_input("Member ID", min_value=1)
        reservation_date = st.date_input("Reservation Date")
        submit = st.form_submit_button("Add Reservation")
        if submit:
            run_query("INSERT INTO Reservations (BookID, MemberID, ReservationDate) VALUES (%s, %s, %s)", (book_id, member_id, reservation_date))
            st.success("Reservation Added!")
