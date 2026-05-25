library(shiny) #Main package for the interactive dashboard
library(shinydashboard) #Simplifies creation of the dashboard layout
library(bslib) #Customizes the app's look and colors
library(plotly) #Creates graphs
library(DT) #Display data tables
library(readxl) #Allows the app read data from an Excel file
library(writexl) #Allows saving data from the dashboard into an Excel file
library(shinyBS) #Adds pop-up messages, and collapsible panels
library(shinyjs) #Allows adding features like hiding buttons or showing messages 
library(bslib) #Customizes the app's look and colors
library(magrittr) #Helps make code easier to read and follow using %>% shortcuts
library(lubridate) #Makes working with dates and times more simple
library(dplyr) #Helps in data cleaning and handling

# Define user credentials: holds user data for authentication
credentials <- readRDS("credentials.rds")

#Display of log in page layout and style with CSS styling using HTML <style>
login_ui <- function() {
  fluidPage(
    tags$head(
      tags$style(HTML("
        body.login-page {
          background-color: #f7f7f7;
          height: 100vh;
          margin: 0;
          overflow: hidden;
        }
        .login-container {
          height: 100vh;
          display: flex;
          justify-content: center;
          align-items: center;
        }
        .login-panel {
          width: 350px;
          padding: 30px;
          box-shadow: 0 0 15px rgba(0,0,0,0.2);
          border-radius: 10px;
          background-color: #ffffff;
        }
        .btn {
          border-radius: 6px;
          font-weight: 500;
        }
        .btn-outline-primary {
          color: #007bff;
          border-color: #007bff;
          background-color: transparent;
        }
        .btn-outline-danger {
          color: #dc3545;
          border-color: #dc3545;
          background-color: transparent;
        }
        .btn-login {
          background-color: #006d2c;
          border: none;
          color: white;
          width: 100%;
          padding: 10px;
          font-weight: bold;
          border-radius: 6px;
          transition: background-color 0.3s ease;
        }
        .btn-login:hover {
          background-color: #004b1c;
        }
  
      "))
    ),
    tags$body(class = "login-page", 
              div(class = "login-container",
                  div(class = "login-panel",
                      h3("Admin Login", align = "center"),
                      textInput("username", "Username"),
                      passwordInput("password", "Password"),
                      actionButton("login", "Log In", class = "btn-login"),
                      br(),
                      textOutput("login_message"),
                      actionLink("forgot_pwd", "Forgot Password?", style = "color:#007bff; display:block; margin-top: 10px; text-align:center;")
                      
                  )
              )
    )
  )
}

# Main UI: Header, sidebar, and body section of the user-interface
main_ui <- dashboardPage(
  dashboardHeader(
    title = tags$a(
      href = "#",
      tags$img(src = "logo_full.png", id = "logo-full", height = "50px"),
      tags$img(src = "logo_icon.png", id = "logo-icon", height = "50px", 
               style = "display: none;")
    ),
    titleWidth = 250,
    tags$li(
      class = "dropdown",
      style = "padding: 8px 10px; list-style: none;",
      actionButton("change_pwd_btn", "Change Password", icon = icon("key"),
                   class = "btn btn-outline-primary no-border", style = "padding: 6px 10px;"),
      actionButton("logout", "Log Out", icon = icon("sign-out-alt"),
                   class = "btn btn-outline-danger no-border", style = "padding: 6px 10px;")
    )
  ),
  
  dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      menuItem("Home", tabName = "home", icon = icon("house")),
      menuItem("Overview", tabName = "overview", icon = icon("chart-bar")),
      menuItem("Attendance Log", tabName = "log", icon = icon("calendar-check")),
      menuItem("Service Credits", tabName = "credits", icon = icon("clock")),
      menuItem("Teachers' Profile", tabName = "profiles", icon = icon("users")),
      menuItem("User Manual", tabName = "manual", icon = icon("book")),
      menuItem("Data Privacy", tabName = "privacy", icon = icon("lock"))
    )
  ),
  
  dashboardBody(
    useShinyjs(),
    tags$head(
      #DataTable CSS Styling
      tags$style(HTML("
        table.dataTable td, 
        table.dataTable th {
          white-space: nowrap;
        }
        table.dataTable thead input {
          width: 100% !important;
          box-sizing: border-box;
        }
        .no-border {
          background-color: transparent;
          border: none;
          color: #f8f8f0; 
        }
        .no-border:hover {
          background-color: #006d2c; 
          color: #ffffff; 
        }
      ")),
      
      #Header, sidebar, logo, content area CSS styling
      tags$style(HTML("
        #logo-full {
          display: inline;
        }
        #logo-icon {
          display: none;
        }
        .main-header .logo {
          background-color: #238b45 !important;
          color: white !important;
          width: 150px !important;
          display: flex;
          align-items: center;
          justify-content: center;
          padding: 0 !important;
          overflow: hidden;
          transition: all 0.6s ease-in-out,
        }
        .main-header .logo img {
          max-height: 60px;
          max-width: 100%;
          transition: all 1s ease-in-out;
        }
        .main-header .navbar {
          background-color: #41ab5d !important;  
          margin-left: 150px !important;
          transition: all 0.3s ease;
          margin-left: 150px !important;
        }
        .main-sidebar {
          background-color: #41ab5d !important;  
          width: 150px !important;
          transition: all 0.3s ease;
        }
        .sidebar-menu > li > a {
          color: #ffffff !important;
        }
        .sidebar-menu > li.active > a,
        .sidebar-menu > li:hover > a {
          background-color: #006d2c !important; #3f5f7f !important; /* lighter muted blue */
          color: #ffffff !important;
        }
        .content-wrapper, .right-side {
          margin-left: 150px !important;
          min-height: 100vh !important;
        }
        .content-wrapper,
          .main-footer {
          margin-left: 150px;
        }
      ")),
      
      #Logo display, resizing CSS Styling
      #Sidebar layout when collapsed styling and responsiveness
      #Animations for header, sidebar, and content area
      tags$style(HTML("
        .sidebar-collapse #logo-full {
          display: none !important;
        }
        .sidebar-collapse #logo-icon {
          display: inline !important;
        }
        .sidebar-collapse .main-header .logo {
          justify-content: flex-start !important;
          padding-left: 10px !important;
        }
        .main-header .logo img {
          height: 40px;
          transition: all 0.3s ease;
        }
        .sidebar-collapse .main-sidebar {
          margin-left: 60px !important;
        }
        .sidebar-collapse .main-header .logo img {
          justify-content: left;
          height: 40px; 
        }
       .sidebar-collapse .main-header .navbar {
          margin-left: 60px !important;
        }
        .sidebar-collapse .content-wrapper,
        .sidebar-collapse .main-footer {
          margin-left: 0px !important;
        }
        .main-header .sidebar-toggle {
          margin-left: 0px;
          transition: all 0.3s ease;
        }
        .sidebar-collapse .main-header .sidebar-toggle {
          margin-left: -90px; /* or adjust to your liking */
        }
        @media screen and (max-width: 768px) {
          .main-header .logo {
            width: auto !important;
            padding: 0 10px;
          }
          .main-sidebar {
            width: auto !important;
            min-width: 60px !important;
          }
          #logo-full {
            max-height: 40px;
          }
          #logo-icon {
            max-height: 40px;
          }
          .main-header .navbar {
            margin-left: 0 !important;
          }
          .sidebar-collapse .main-sidebar {
            margin-left: 0 !important;
          }
          .content-wrapper, .right-side {
            margin-left: 0 !important;
          }
        }
        .main-header, .main-sidebar, .content-wrapper {
          transition: all 0.3s ease;
        }
      ")),
      
      #Behavior of logo in dashboard header CSS styling
      tags$style(HTML("
        .main-header .logo {
          position: relative;
        }
      
        #logo-full, #logo-icon {
          position: absolute;
          left: 50%;
          top: 50%;
          transform: translate(-50%, -50%);
          transition: all 0.3s ease;
          max-height: 60px;
        }
      
        #logo-full {
          opacity: 1;
          z-index: 2;
        }
      
        #logo-icon {
          opacity: 0;
          z-index: 1;
        }
      
        .sidebar-collapse #logo-full {
          opacity: 0 !important;
        }
      
        .sidebar-collapse #logo-icon {
          opacity: 1 !important;
        }
        .sidebar-collapse .main-header .logo {
          justify-content: flex-start !important;
          padding-left: 15px !important;
        }
        
        .sidebar-collapse #logo-full,
        .sidebar-collapse #logo-icon {
          left: 9% !important;
          transform: translate(0%, -50%) !important;
        }
    ")),
      
      #Customizes appearance of boxes and DataTables
      #Just add class= "custom-box"
      tags$style(HTML("
      .custom-box > .box-header {
        background-color: #238b45 !important;
        color: white;
        text-transform: uppercase;
        font-weight: bold;
        font-size: 14px;
        position: relative;
      }
      .custom-box1 h4 {
        background-color: #238b45;
        color: white;
        text-transform: uppercase;
        font-weight: bold;
        font-size: 14px;
        padding: 6px 10px;
        margin: 0 0 10px 0;
        border-radius: 0;  
      }
      .custom-box1 {
        background: none !important;
        box-shadow: none !important;
        padding: 0 !important;
        margin: 0 !important;
        border-radius: 0 !important; 
      }
      .custom-box1 table {
        width: 100% !important;
        max-width: 100% !important;
        table-layout: auto !important;
        border-collapse: collapse !important;
      }
      .custom-box1 .dataTables_wrapper {
        padding: 0;
        margin: 0;
      }
      .custom-box1 table.dataTable td,
      .custom-box1 table.dataTable th {
        white-space: normal !important;   
        word-wrap: break-word !important; 
        text-align: left;
        vertical-align: middle;
        font-size: 14px;
      }
      @media screen and (max-width: 600px) {
        /* Hide the table body rows on small screens */
        .custom-box1 table tbody {
          display: none !important;
        }
        .custom-box1 table thead th {
          font-size: 14px;
          padding: 8px 6px;
        }
      }
    ")),
      
      #Customizes valueBoxes
      #Add class = ".overview-boxes"
      tags$style(HTML("
      .overview-boxes .small-box {
        margin-bottom: 10px !important;
        min-height: 120px;
      }
      .overview-boxes .small-box .inner {
        padding: 10px;
      }
    ")),
      
      #Styles dateInput widgets
      tags$style(HTML("
      .custom-box {
        background-color: #f9f9f9;
        border-radius: 10px;
        padding: 10px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      }
      .date-input-container {
        display: flex;
        align-items: center;
        justify-content: flex-start; 
        gap: 10px; 
        margin-top: 0px;
      }
      .date-input-label {
        font-size: 16px;
        color: #444;
        white-space: nowrap; 
        line-height: 1.2;     
        margin: 0;            
        padding: 0;
      }
      .date-input-container .form-group {
        margin-bottom: 10px; 
      }
      .date-input-container input.form-control {
        border: 2px solid #28a745;
        border-radius: 8px;
        padding: 8px 12px;
        font-size: 16px;
        box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
        transition: all 0.3s ease-in-out;
      }
      .date-input-container input.form-control:focus {
        border-color: #218838;
        box-shadow: 0 0 5px rgba(33,136,56,0.5);
      }
      .date-input-container .form-group {
        margin-bottom: 10;
      }
      
    ")),
      #Styles title box, just the header not the the whole box
      tags$style(HTML("
      .title-box {
        background-color: #28a745; 
        color: #ffffff;
        padding: 5px 10px;
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 15px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      }
    ")),
      
      #Overview tab: Hoverboxes
      tags$style(HTML("
      .hover-box {
        position: relative;
      }
      .hover-box .box {
        padding: 10px;
        color: #fff;
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        min-height: 80px;
        border-radius: 0px;
        box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        transition: opacity 0.3s ease;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
      }
      .hover-box .box .inner {
        flex-grow: 1;
      }
      .hover-box .box .inner h3 {
        font-size: 42px;
        font-weight: bold;
        margin: 0;
      }
      @media screen and (max-width: 768px) {
        .hover-box .box .inner h3 {
          font-size: 36px;
        }
      }
      .hover-box .box .icon {
        font-size: 35px;
        opacity: 0.2;
        align-self: flex-end;
      }
      .front-box {
        z-index: 1;
        opacity: 1;
      }
      .back-box {
        z-index: 0;
        opacity: 0;
      }
      .hover-box:hover .front-box {
        z-index: 0;
        opacity: 0;
      }
      .hover-box:hover .back-box {
        z-index: 1;
        opacity: 1;
      }
      .bg-green {
        background-color: #28a745;
      }
      .bg-blue {
        background-color: #007bff;
      }
      .bg-orange {
        background-color: #fd7e14;
      }
      @media screen and (max-width: 768px) {
        .hover-box .box {
          min-height: 120px;
          padding: 10px;
        }
        .hover-box .box .icon {
          font-size: 28px;
        }
      }
    ")),
      
      #Overview tab: Birthday reminder
      tags$style(HTML("
        .birthday-box {
        padding: 0px;
        background-color: #e6f7f1;
        border-radius: 0px;
        max-height: 350px;
        margin-bottom: 8px;
        overflow-y: auto;
      }
      .birthday-card {
        background-color: #d0f0c0;
        margin-bottom: 8px;
        padding: 8px 12px;
        border-radius: 0px;
        font-size: 13px;
        font-weight: 500;
        color: #2c5f2d;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
      }
    ")),
      
      #Home tab background 
      tags$style(HTML("
        .home-background {
          background-image: url('school.jpg');
          background-size: cover;
          background-position: center;
          background-repeat: no-repeat;
          padding: 30px;
          min-height: 100vh;
          color: white;
          position: relative;
        }
        .home-background::before {
          content: '';
          position: absolute;
          top: 0; left: 0; right: 0; bottom: 0;
          background-color: rgba(0, 0, 0, 0.4);
          z-index: 0;
        }
        .home-background > * {
          position: relative;
          z-index: 1;
        }
        .info-box {
          color: white;
          padding: 30px;
          border-radius: 8px;
          min-height: 140px;
          display: flex;
          flex-direction: column;
          justify-content: center;
          word-wrap: break-word;
        }
        .box-overview {background-color: #38A169; color: white;}
        .box-attendance { background-color: #4A5568; color: white;}
        .box-service { background-color: #68D391; color: #1A202C;}
        .box-profile { background-color: #A0AEC0; color: #1A202C;}
        .box-manual { background-color: #2F855A; color: white;}
      "))
    ),
    
    #UI layout of different tabs
    tabItems(
      tabItem(tabName = "home",
              div(class = "home-background",
                  fluidRow(
                    column(width = 12,
                           div(class = "welcome-box",
                               h2("Welcome to the GuroTrack!"),
                               p("This app helps you track attendance, monitor service milestones, analyze work hours across departments, and many more!"),
                               br(),
                               h4("Tab Descriptions:"),
                               fluidRow(
                                 column(width = 4,
                                        div(
                                          class = "info-box box-overview",
                                          h4(strong("Overview")),
                                          span(style = "font-size: 14px; margin-top: 8px;", "View birthdays, service milestones, and attendance summaries.")
                                        )
                                 ),
                                 column(width = 4,
                                        div(
                                          class = "info-box box-attendance",
                                          h4(strong("Attendance Log")),
                                          span(style = "font-size: 14px; margin-top: 8px;", "Complex time cards made easier. Useful simple table displaying attendance log uploaded in the system.")
                                        )
                                 ),
                                 column(width = 4,
                                        div(
                                          class = "info-box box-service",
                                          h4(strong("Service Credit")),
                                          span(style = "font-size: 14px; margin-top: 8px;", "Manage local and national service credits with customizable local credits expiration date.")
                                        )
                                 )
                               ),
                               br(),
                               fluidRow(
                                 column(width = 6,
                                        div(
                                          class = "info-box box-profile",
                                          h4(strong("Teachers Profile")),
                                          span(style = "font-size: 14px; margin-top: 8px;", "Manage teacher profiles and service years.")
                                        )
                                 ),
                                 column(width = 6,
                                        div(
                                          class = "info-box box-manual",
                                          h4(strong("User Manual")),
                                          span(style = "font-size: 14px; margin-top: 8px;", "Need help in navigating functions of GuroTrack? User Manual is here for you!")
                                        )
                                 )
                               )
                           )
                    )
                  )
              )
      ),
      
      tabItem(tabName = "overview",
              # 🎂 Birthday Reminder Box Here
              fluidRow(
                column(
                  width = 5,
                  div(class = "title-box", "🎂 Upcoming Birthdays"),
                  div(class = "custom-box birthday-box", uiOutput("birthday_reminders_ui"))
                ),
                column(
                  width = 7,
                  div(class = "custom-box1",
                      h4("🏅 Years of Service Milestones"),
                      DTOutput("service_anniversary_ui"))
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 12,
                  div(class = "title-box", "📊 Daily Status Summary"), 
                  div(
                    class = "date-input-container",
                    span(class = "date-input-label", "Select a date to summarize:"),
                    dateInput("attendance_date", NULL, value = Sys.Date())
                  )
                )
              ),
              fluidRow(
                column(width = 4, uiOutput("normal_hours_ui")),
                column(width = 4, uiOutput("overtime_ui")),
                column(width = 4, uiOutput("undertime_ui"))
              ),
              br(), br(), br(), br(), br(), br(), br(), br(), br(),
              fluidRow(
                column(6, uiOutput("most_rendered_ui")),
                column(6, uiOutput("least_rendered_ui"))
              ),
              fluidRow(
                column(
                  width = 7,
                  
                  div(class = "custom-box1",
                      h4("📊 Daily Attendance Count by Department"),
                      div(
                        class = "date-input-container",
                        span(class = "date-input-label", "Select a date to summarize:"),
                        dateInput("attendance_date1", NULL, value = Sys.Date())
                      ),
                      plotOutput("daily_attendance_count_plot", height = "300px")
                  )
                ),
                column(
                  width = 5,
                  
                  
                  
                  div(class = "custom-box1",
                      h4("⏱️ Average Hours Worked per Day per Department"),
                      div(
                        class = "date-input-container",
                        span(class = "date-input-label", "Select a date range:"),
                        dateRangeInput("attendance_date_range", NULL,
                                       start = Sys.Date() - 7, end = Sys.Date())
                      ),
                      plotOutput("avg_hours_worked_plot", height = "300px")
                  )
                )
              )
              
      ),
      
      tabItem(tabName = "log",
              fluidRow(
                box(title = "Upload Attendance Log (Excel)", 
                    status = "success", width = 4,
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    class = "custom-box",
                    fileInput("file_upload", "Choose Excel File (.xlsx)", accept = c(".xls", ".xlsx")),
                    selectInput("rows_per_page", "Show entries per page:",
                                choices = c(10, 25, 50, 100), selected = 10, width = "100%"),
                    actionButton("save_changes", "Save Changes", icon = icon("save"))
                ),
                box(
                  title = strong("INSTRUCTIONS FOR ATTENDANCE LOG USE:"), 
                  status = "success", 
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  class = "custom-box",
                  width = 8,
                  tags$ul(
                    tags$li("TIME IN and TIME OUT should be entered in 24-hour format (e.g., 07:30, 13:00) for accurate time calculation and status recognition."),
                    tags$li("Save any changes you make before logging out to avoid losing your data."),
                    tags$li("You have the option to download the entire attendance log or just the rows you selected."),
                    strong("REMINDERs:"),
                    tags$li("Uploading Excel files with multiple sheets might take 3-8 minutes. A notification will appear if the file is successfully uploaded."),
                  )
                )
                
              ),
              
              fluidRow(
                box(title = "Compiled Attendance Log", status = "success", width = 12,
                    solidHeader = TRUE,
                    class = "custom-box",
                    actionButton("select_all", "Select All", class = "btn-success"),
                    actionButton("select_current_page", "Select Current Page", class = "btn-secondary"),
                    actionButton("deselect_all", "Deselect All", class = "btn-secondary"),
                    br(), br(),
                    DTOutput("editable_table"),
                    actionButton("delete_row", "Delete Selected", icon = icon("trash"), class = "btn-danger"),
                    actionButton("undo_delete", "Undo Delete", icon = icon("undo")),
                    downloadButton("download_log", "Download Current Log", icon = icon("download")),
                    downloadButton("download_selected", "Download Selected Rows", icon = icon("file-download")),
                    br(),
                    radioButtons("download_format", "Choose format:", choices = c("Excel", "SQL"))
                )
              )
      ),
      
      tabItem(tabName = "credits",
              fluidRow(
                box(title = "Upload Service Credits Log (Excel)", status = "success", width = 4,
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    class = "custom-box",
                    fileInput("creds_file_upload", "Choose Excel File (.xlsx)", accept = c(".xls", ".xlsx")),
                    selectInput("creds_rows_per_page", "Show entries per page:",
                                choices = c(10, 25, 50, 100), selected = 10, width = "100%"),
                    actionButton("creds_save_changes", "Save Changes", icon = icon("save"))
                ),
                box(
                  title = strong("INSTRUCTIONS FOR SERVICE CREDITS USE:"),
                  status = "success",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  class = "custom-box",
                  width = 8,
                  tags$ul(
                    tags$li(strong("Set an Expiry Date:"), " Before uploading, ensure you have set an expiry date for the local service credits. THE DEFAULT EXPIRY DATE IS THE SYSTEM DATE."),
                    tags$li(strong("Prepare your Excel file (.xls or .xlsx):"), ":"),
                    tags$ul(
                      tags$li("The file must contain the following column headers exactly as shown, including capitalization and spacing:"),
                      tags$ul(
                        tags$li(strong("EMPLOYEE.NUMBER"), ": Unique employee identifier."),
                        tags$li(strong("EMPLOYEE.NAME"), ": Full name of the employee."),
                        tags$li(strong("DEPARTMENT"), ": Department name."),
                        tags$li(strong("POSITION"), ": Employee's position."),
                        tags$li(strong("LOCAL.SERVICE.CREDITS"), ": Numeric value of local service credits."),
                        tags$li(strong("NATIONAL.SERVICE.CREDITS"), ": Numeric value of national service credits.")
                      )
                    ),
                    tags$li("Ensure headers are in the first row of your Excel sheet and match exactly as listed above. Headers are case-sensitive."),
                    tags$li("The columns 'EMPLOYEE.NUMBER', 'EMPLOYEE.NAME', and 'DEPARTMENT' are required for processing."),
                    tags$li("After uploading, you can edit service credits directly within the table. Remember to save your changes using the action buttons."),
                  )
                )
              ),
              
              
              fluidRow(
                box(title = "Edit Service Credits Data", status = "success", width = 12,
                    solidHeader = TRUE,
                    class = "custom-box",
                    dateInput("local_credit_expiry", "Set Expiry Date"), 
                    textOutput("current_expiry_date"),  # This is the new output for current expiry date
                    actionButton("save_credit_expiry", "💾 Save Expiry Date", icon = icon("save")),
                    actionButton("creds_select_all", "Select All", class = "btn-success"),
                    actionButton("creds_select_current_page", "Select Current Page", class = "btn-secondary"),
                    actionButton("creds_deselect_all", "Deselect All", class = "btn-secondary"),
                    br(), br(),
                    box(title = "Editable Service Credits Table", status = "success", width = NULL,  # New box for the table
                        DTOutput("creds_editable_table")  # Output for the editable table
                    ),
                    br(),
                    actionButton("creds_delete_row", "Delete Selected", icon = icon("trash"), class = "btn-danger"),
                    actionButton("creds_undo_delete", "Undo Delete", icon = icon("undo")),
                    downloadButton("creds_download_log", "Download Current Log", icon = icon("download")),
                    downloadButton("creds_download_selected", "Download Selected Rows", icon = icon("file-download")),
                    br(),
                    radioButtons("creds_download_format", "Choose format:", choices = c("Excel", "SQL")
                    )
                )
              )
      ),
      
      tabItem(tabName = "profiles",
              fluidRow(
                box(title = "Upload Teacher Profile (Excel)", status = "success", width = 4,
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    class = "custom-box",
                    fileInput("prof_file_upload", "Choose Excel File (.xlsx)", accept = c(".xls", ".xlsx")),
                    selectInput("prof_rows_per_page", "Show entries per page:",
                                choices = c(10, 25, 50, 100), selected = 10, width = "100%"),
                    actionButton("prof_save_changes", "Save Changes", icon = icon("save"))
                ),
                box(
                  title = strong("INSTRUCTIONS FOR TEACHER PROFILE UPLOAD:"), 
                  status = "success", 
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  class = "custom-box",
                  width = 8,
                  tags$ul(
                    tags$li("Upload the teacher profile file in Excel format (.xlsx)."),
                    tags$li("The file must be in a tabular format, with clearly labeled headers in the first row."),
                    tags$li("Required column headers (case-sensitive):"),
                    tags$ul(
                      tags$li("Name"),
                      tags$li("Position"),
                      tags$li("Original Date of Appointment"),
                      tags$li("Reclass/Promotion Date of Appointment"),
                      tags$li("Employee Number"),
                      tags$li("Birthday")
                    ),
                    tags$li("After uploading, you can edit the data directly in the table."),
                    tags$li("Use the action buttons to save changes and manage your data."),
                    tags$li("You can download the entire log or selected rows after making changes — be sure to save modifications before downloading.")
                  )
                )
                
              ),
              
              
              fluidRow(
                box(title = "Teacher Profile Data", status = "success", width = 12,
                    solidHeader = TRUE,
                    class = "custom-box",
                    actionButton("prof_select_all", "Select All", class = "btn-success"),
                    actionButton("prof_select_current_page", "Select Current Page", class = "btn-secondary"),
                    actionButton("prof_deselect_all", "Deselect All", class = "btn-secondary"),
                    br(), br(),
                    box(title = "Teacher Profiles", status = "success", width = NULL,  # New box for the table
                        DTOutput("prof_editable_table")  # Output for the editable table
                    ),
                    br(),
                    actionButton("prof_delete_row", "Delete Selected", icon = icon("trash"), class = "btn-danger"),
                    actionButton("prof_undo_delete", "Undo Delete", icon = icon("undo")),
                    downloadButton("prof_download_log", "Download Current Log", icon = icon("download")),
                    downloadButton("prof_download_selected", "Download Selected Rows", icon = icon("file-download")),
                    br(),
                    radioButtons("prof_download_format", "Choose format:", choices = c("Excel", "SQL")
                    )
                )
              )
      ),
      
      tabItem(tabName = "manual",
              fluidRow(
                box(
                  title = "User Manual",
                  width = 12,
                  status = "success",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  tags$div(
                    tags$h4("HOW TO USE GURO TRACK?"),
                    tags$p("For a more detailed guide with screenshots, you may download the full User Manual here:"),
                    tags$a(href = "HOW TO USE GUROTRACK.pdf", 
                           target = "_blank", 
                           "📄 Download User Manual (PDF)"),
                    tags$br(), tags$br(),
                    tags$h5("Log In Screen:"),
                    tags$ul(
                      tags$li("Log In button: You will first see the login screen and will be asked to enter your username and password. If this is the first time you use the app, your permanent username is “admin” while the default password is “1234”. Click the “Log In” button to access the main user-interface."),
                      tags$li("Error message: When you click the button and the text boxes for password and username reset, a message saying “Invalid username or password. Please try again.” will appear under the Log In button. This means you entered an incorrect username or password. These are case sensitive."),
                      tags$li("Forgot Password? button: If you forget your password, the admin will have access to the current password log. Once clicked, a dialog box will appear with instructions. There is a password log secured by the admin personnel.")
                    ),
                    
                    tags$h5("Main Dashboard:"),
                    tags$ul(
                      tags$li("Home Tab: After a successful log in, you’ll be redirected to the main dashboard. The Home tab shows a short introduction for each tab."),
                      tags$li("Overview Tab: Displays birthday and service anniversary reminders, daily status summary, highest and lowest monthly total hours, daily attendance count, and average hours worked per department. The contents are dependent on selected dates."),
                      tags$ul(
                        tags$li("Red - Summary boxes are based on the red-circled date. The same date’s month determines the monthly highest and lowest total hours."),
                        tags$li("Pink - Daily Attendance Count graph is based on the pink-circled date."),
                        tags$li("Green - Average Hours Rendered graph is based on the green-circled date range. Choose two dates to act as your data range.")
                      ),
                      tags$li("Attendance Log, Service Credits, and Teacher’s Profile Tabs: Each has an upload button and a data table displaying different contents per tab.")
                    ),
                    
                    tags$h5("File Upload Process (applies to Attendance Log, Service Credits, and Teacher’s Profile tabs):"),
                    tags$ol(
                      tags$li("Click 'Browse' and wait for the file picker pop-up."),
                      tags$li("Choose a valid file to upload."),
                      tags$li("Wait for the confirmation message indicating successful upload.")
                    ),
                    tags$p("Notifications to watch for:"),
                    tags$ul(
                      tags$li("“All rows already exist in the data. No new data uploaded” – appears if the uploaded file is a duplicate."),
                      tags$li("“### duplicate row(s) found and skipped” – appears if some rows are duplicates."),
                      tags$li("“Failed to process sheet” – appears if the file is invalid.")
                    ),
                    
                    tags$h5("Tab Details:"),
                    tags$ul(
                      tags$li("Attendance Log Tab: Displays User ID, Name, Department, Date, Time In, and Time Out with system-computed Hours Rendered and Status."),
                      tags$li("Service Credits Tab: Shows employee details, Local Service Credit, National Service Credit, and system-computed Total Service Credit. Local Service Credit expires on a set expiry date."),
                      tags$li("Teacher’s Profile Tab: Contains employee details, Original Date of Appointment, Reclass, and system-computed Total Years of Service.")
                    ),
                    
                    tags$h5("General Table Buttons (available in all data tabs):"),
                    tags$ul(
                      tags$li("Select All: Check all rows."),
                      tags$li("Select Current Page: Check all rows on the current page."),
                      tags$li("Deselect All: Uncheck all selected rows."),
                      tags$li("Show rows per page: Adjust number of rows shown."),
                      tags$li("Delete Selected: Remove checked rows."),
                      tags$li("Undo Delete: Restore recently deleted rows."),
                      tags$li("Download Current Log: Export entire table."),
                      tags$li("Download Selected Rows: Export selected rows only."),
                      tags$li("Choose format: Pick Excel or SQL for downloads."),
                      tags$li("Search bar: Search records within the table."),
                      tags$li("Save Changes: Save changes to persist data after logout.")
                    ),
                    
                    tags$h5("Other Tabs:"),
                    tags$ul(
                      tags$li("User Manual: Displays instructions on using the app."),
                      tags$li("Data Privacy: Contains the app’s data privacy statements.")
                    ),
                    
                    tags$h5("Change Password:"),
                    tags$p("Click the 'Change Password' button and enter the required information. Click Submit, and the app will refresh. Log in again with your new password."),
                    
                    tags$h5("Log Out:"),
                    tags$p("Click the 'Log Out' button to return to the login screen. You’ll be prompted to enter your credentials again.")
                  )
                )
              )
      ),
      
      tabItem(tabName = "privacy",
              fluidRow(
                box(
                  title = "Data Privacy Statement",
                  width = 12,
                  status = "success",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  HTML("
                    <p>This application strictly adheres to the provisions of the 
                    <strong>Data Privacy Act of 2012 (Republic Act No. 10173)</strong> and its Implementing Rules and Regulations (IRR), 
                    which provide the legal framework for the protection of personal data in the Philippines.</p>
            
                    <p>We are committed to ensuring the privacy, confidentiality, and security of all personal information collected, processed, stored, and transmitted through this system. 
                    The types of personal data collected may include, but are not limited to, names, identification numbers, contact information, attendance records, and other data relevant to the provision of services.</p>
            
                    <p>In compliance with the Act, the following principles are upheld:</p>
                    <ul>
                      <li><strong>Transparency:</strong> Data subjects are informed of the purpose and scope of data collection and processing.</li>
                      <li><strong>Legitimate Purpose:</strong> Personal data are collected and processed only for legitimate and lawful purposes necessary to fulfill the functions of this application.</li>
                      <li><strong>Data Minimization:</strong> Only personal information that is relevant and necessary for the intended purpose is collected.</li>
                      <li><strong>Security Measures:</strong> Appropriate administrative, technical, and physical controls are implemented to protect personal data against unauthorized or unlawful access, disclosure, alteration, and destruction.</li>
                      <li><strong>Access and Correction:</strong> Data subjects have the right to access, correct, or update their personal data in accordance with the law.</li>
                      <li><strong>Data Retention:</strong> Personal data are retained only as long as necessary for the fulfillment of the purposes for which they were collected and in compliance with applicable laws and policies.</li>
                    </ul>
            
                    <p>All users of this system are expected to comply with the Data Privacy Act and respect the confidentiality of personal data handled. Any unauthorized use, disclosure, or breach of personal data will be subject to disciplinary and legal action.</p>
            
                    <p>For more information about the Data Privacy Act of 2012 and its IRR, please visit the official website: 
                    <a href='https://privacy.gov.ph/the-data-privacy-act-and-its-irr/' target='_blank' rel='noopener noreferrer'>https://privacy.gov.ph/the-data-privacy-act-and-its-irr/</a></p>
            
                    <p>For questions, concerns, or requests related to your personal data, please contact the designated Data Protection Officer or system administrator.</p>
                  ")
                )
              )
      )
      
    )
  )
)

#Helper function for processing data uploaded in the attendance log tab
process_sheet <- function(file_path, sheet_name) {
  df <- read_excel(file_path, sheet = sheet_name, col_names = FALSE)
  header_rows <- head(df, 12)
  
  #Extract user info for 3 users from specific cells only. Example on the first block
  user_ids <- header_rows[5, 10]   #UserID1: row 5, col 10
  names_ <- header_rows[4, 10]     #Name1: row 4, col 10
  depts <- header_rows[4, 2]       #Department1: row 4, col 2
  
  user_ids2 <- header_rows[5, 25]  #UserID2: row 5, col 25
  names_2 <- header_rows[4, 25]    #Name2: row 4, col 25
  depts2 <- header_rows[4, 17]     #Department2: row 4, col 17
  
  user_ids3 <- header_rows[5, 40]  #UserID3: row 5, col 40
  names_3 <- header_rows[4, 40]    #Name3: row 4, col 40
  depts3 <- header_rows[4, 32]     #Department3: row 4, col 32
  
  #Store header info in a named list for easy reference
  header_info <- list(
    UserID = as.character(user_ids[1]),
    Name = as.character(names_[1]),
    Dept = as.character(depts[1]),
    UserID2 = as.character(user_ids2[1]),
    Name2 = as.character(names_2[1]),
    Dept2 = as.character(depts2[1]),
    UserID3 = as.character(user_ids3[1]),
    Name3 = as.character(names_3[1]),
    Dept3 = as.character(depts3[1])
  )
  
  data_rows <- df[-(1:12), ]
  # Remove empty rows
  data_rows <- data_rows[!apply(data_rows, 1, function(r) all(is.na(r) | r == "")), ]
  colnames(data_rows) <- paste0("col", 1:ncol(data_rows))
  
  #Initalize an empty data.fram to store extracte time log
  extracted_data <- data.frame(
    UserID = character(),
    Name = character(),
    Dept = character(),
    Date = as.Date(character()),
    TimeIn1 = character(),
    TimeOut1 = character(),
    TimeIn2 = character(),
    TimeOut2 = character(),
    OvertimeIn = character(),
    OvertimeOut = character(),
    stringsAsFactors = FALSE
  )
  
  #Loop through each data row to process attendance info
  for (i in 1:nrow(data_rows)) {
    row <- data_rows[i, ]
    date_cell <- as.character(row[[1]])
    date_value <- convert_to_date(date_cell)
    if (is.na(date_value)) next
    
    # Collect all time values for each card
    times1 <- c(
      decimal_to_time(as.character(row[[2]])),
      decimal_to_time(as.character(row[[4]])),
      decimal_to_time(as.character(row[[7]])),
      decimal_to_time(as.character(row[[9]])),
      decimal_to_time(as.character(row[[11]])),
      decimal_to_time(as.character(row[[13]]))
    )
    
    times2 <- c(
      decimal_to_time(as.character(row[[17]])),
      decimal_to_time(as.character(row[[19]])),
      decimal_to_time(as.character(row[[22]])),
      decimal_to_time(as.character(row[[24]])),
      decimal_to_time(as.character(row[[26]])),
      decimal_to_time(as.character(row[[28]]))
    )
    
    times3 <- c(
      decimal_to_time(as.character(row[[32]])),
      decimal_to_time(as.character(row[[34]])),
      decimal_to_time(as.character(row[[37]])),
      decimal_to_time(as.character(row[[39]])),
      decimal_to_time(as.character(row[[41]])),
      decimal_to_time(as.character(row[[43]]))
    )
    
    # Function to extract TimeIn and TimeOut from times vector
    get_timein_timeout <- function(times_vec) {
      times_nonblank <- times_vec[times_vec != "" & !is.na(times_vec)]
      if (length(times_nonblank) == 1) {
        TimeIn <- times_nonblank[1]
        TimeOut <- ""
      } else if (length(times_nonblank) >= 2) {
        times_sorted <- sort(times_nonblank)
        TimeIn <- times_sorted[1]
        TimeOut <- times_sorted[length(times_sorted)]
      } else {
        TimeIn <- ""
        TimeOut <- ""
      }
      return(list(TimeIn = TimeIn, TimeOut = TimeOut))
    }
    
    # Get TimeIn/TimeOut for each time card
    card1 <- get_timein_timeout(times1)
    card2 <- get_timein_timeout(times2)
    card3 <- get_timein_timeout(times3)
    
    # Append each time card's data as a separate row
    extracted_data <- rbind(
      extracted_data, 
      data.frame(UserID = header_info$UserID, Name = header_info$Name, Dept = header_info$Dept,
                 Date = date_value, TimeIn = card1$TimeIn, TimeOut = card1$TimeOut, stringsAsFactors = FALSE),
      data.frame(UserID = header_info$UserID2, Name = header_info$Name2, Dept = header_info$Dept2,
                 Date = date_value, TimeIn = card2$TimeIn, TimeOut = card2$TimeOut, stringsAsFactors = FALSE),
      data.frame(UserID = header_info$UserID3, Name = header_info$Name3, Dept = header_info$Dept3,
                 Date = date_value, TimeIn = card3$TimeIn, TimeOut = card3$TimeOut, stringsAsFactors = FALSE)
    )
  }
  
  # After the loop, remove any residual blank rows
  extracted_data <- extracted_data[!apply(extracted_data, 1, function(r) all(is.na(r) | r == "")), ]
  
  return(extracted_data)
  
}

# Helper function to process multiple time cells into earliest and latest
get_time_in_out <- function(times) {
  # Convert each time to HH:MM, filter out blanks
  times_converted <- sapply(times, function(t) {
    t <- as.character(t)
    if (is.na(t) || t == "" || t == "0") return(NA)
    decimal_to_time(t)
  })
  times_converted <- na.omit(times_converted)
  
  if (length(times_converted) == 0) {
    return(c("", ""))  # No times
  } else if (length(times_converted) == 1) {
    return(c(times_converted[1], ""))  # Only one time
  } else {
    # Multiple times: earliest and latest
    sorted_times <- sort(times_converted)
    return(c(sorted_times[1], sorted_times[length(sorted_times)]))
  }
}

#Helper function to convert variable x to a Date object for processing
convert_to_date <- function(x) {
  if (inherits(x, "POSIXct") || inherits(x, "Date")) return(as.Date(x))
  if (is.character(x)) {
    day_str <- substr(x, 1, 2)
    day_num <- as.numeric(day_str)
    if (is.na(day_num)) return(NA)
    current_year <- format(Sys.Date(), "%Y")  # Get current year as string
    date_str <- sprintf("%s-04-%02d", current_year, day_num)
    return(as.Date(date_str))
  }
  return(NA)
}

# Convert decimal time to HH:MM format
decimal_to_time <- function(decimal_time) {
  if (is.na(decimal_time) || decimal_time == "" || decimal_time == "0") {
    return("")
  }
  # Convert to numeric
  num <- as.numeric(decimal_time)
  if (is.na(num)) return("")
  # Get total seconds
  total_seconds <- round(num * 24 * 60 * 60)
  hours <- floor(total_seconds / 3600)
  minutes <- floor((total_seconds %% 3600) / 60)
  sprintf("%02d:%02d", hours, minutes)
}

#Logic for buttons, tables, etc. 
server <- function(input, output, session) {
  
  #LOG IN LOGIC
  logged_in <- reactiveVal(FALSE)
  
  #Button observer: Forgot Password
  observeEvent(input$forgot_pwd, {
    credentials <- readRDS("credentials.rds")
    log_message <- paste("[Forgot Password Triggered] Current password is:", credentials$password)
    write(log_message, file = "logs.txt", append = TRUE)
    
    showModal(modalDialog(
      title = "Forgot Password",
      "Please contact the system admin to retrieve your password. It has been logged.",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  #Block observer: Log in, typed info, log in button
  observeEvent(input$login, {
    credentials <- readRDS("credentials.rds")
    
    if (input$username == credentials$username && input$password == credentials$password) {
      logged_in(TRUE)
    } else {
      output$login_message <- renderText("Invalid username or password. Please try again.")
      
      updateTextInput(session, "username", value = "")
      updateTextInput(session, "password", value = "")
    }
  })
  
  #Button observer: Log out
  observeEvent(input$logout, {
    logged_in(FALSE)
    updateTextInput(session, "username", value = "")
    updateTextInput(session, "password", value = "")
    
    output$login_message <- renderText("")
    session$reload()
  })
  
  #Button observer: Change Password
  observeEvent(input$change_pwd_btn, {
    showModal(modalDialog(
      title = "Change Password",
      passwordInput("current_password", "Current Password"),
      passwordInput("new_password", "New Password"),
      passwordInput("confirm_password", "Confirm New Password"),
      footer = tagList(
        modalButton("Cancel"),
        actionButton("submit_password_change", "Submit", class = "btn-primary")
      ),
      easyClose = TRUE
    ))
  })
  
  #Button observer: Submit password
  observeEvent(input$submit_password_change, {
    if (input$current_password != credentials$password) {
      showModal(modalDialog(
        title = "Error",
        "Current password is incorrect.",
        easyClose = TRUE
      ))
    } else if (input$new_password == credentials$password) {  # New condition to check if new password is same as current
      showModal(modalDialog(
        title = "Error",
        "New password cannot be the same as the current password.",
        easyClose = TRUE
      ))
    } else if (input$new_password != input$confirm_password) {
      showModal(modalDialog(
        title = "Error",
        "New password and confirm password do not match.",
        easyClose = TRUE
      ))
    } else if (nchar(input$new_password) < 4) {
      showModal(modalDialog(
        title = "Error",
        "Password must be at least 4 characters long.",
        easyClose = TRUE
      ))
    } else {
      # Update the stored password
      credentials_data <- readRDS("credentials.rds")
      credentials_data$password <- input$new_password
      saveRDS(credentials_data, "credentials.rds")
      
      # Update session's password
      credentials$password <- input$new_password
      
      removeModal()
      showModal(modalDialog(
        title = "Success",
        "Password changed successfully. The application will now reload.",
        easyClose = TRUE,
        footer = NULL 
      ))
      runjs("setTimeout(function() { location.reload(); }, 3000);")  
    }
  })
  
  #Handles what ui will the app show in the interface
  output$ui <- renderUI({
    if (!logged_in()) {
      login_ui()
    } else {
      main_ui
    }
  })
  
  #Reactive expression for specific graphs to re-run automatically
  max_min_employees <- reactive({
    req(attendance_data(), input$attendance_date)
    
    selected_month <- format(input$attendance_date, "%Y-%m")
    
    data_filtered <- attendance_data() %>%
      mutate(DATE = as.Date(DATE)) %>%   # ensure DATE is Date type
      filter(format(DATE, "%Y-%m") == selected_month)
    
    summary_data <- data_filtered %>%
      group_by(USER.ID, NAME) %>%
      summarise(TOTAL_HOURS = sum(HOURS.RENDERED, na.rm = TRUE), .groups = "drop") %>%
      arrange(desc(TOTAL_HOURS))
    
    
    list(
      most_rendered = head(summary_data, 3),
      least_rendered = tail(summary_data, 3)
    )
  })
  
  #ATTENDANCE LOG OBSERVERS AND HANDLERS
  attendance_data <- reactiveVal()
  undo_stack <- reactiveVal(NULL)
  
  # Load persisted data if exists
  if (file.exists("data/updated_attendance.csv")) {
    saved_df <- read.csv("data/updated_attendance.csv", stringsAsFactors=FALSE)
    saved_df <- saved_df[, !names(saved_df) %in% c("X1", "X__1", "Unnamed: 0")]
    saved_df <- saved_df[, !grepl("\\.1$", names(saved_df))]
    names(saved_df) <- trimws(toupper(names(saved_df)))
    attendance_data(saved_df)
  } else {
    attendance_data(data.frame()) 
    
  }
  
  #Observer for uploading a file
  observeEvent(input$file_upload, {
    req(input$file_upload)
    notification_id <- showNotification("📥 Loading Excel file. Please wait...", type = "message", duration = NULL)
    
    tryCatch({
      existing_df <- attendance_data()
      if (is.null(existing_df) || nrow(existing_df) == 0) {
        existing_df <- data.frame()
      }
      
      sheets <- excel_sheets(input$file_upload$datapath)
      sheets_to_process <- sheets[3:length(sheets)]
      
      # Detect duplicate sheet names
      if (any(duplicated(sheets_to_process))) {
        dup_sheets <- sheets_to_process[duplicated(sheets_to_process)]
        showNotification(paste0("⚠️ Duplicate sheet names found: ", paste(dup_sheets, collapse = ", "), ". Skipping duplicates."), type = "warning")
        # Keep only unique sheet names
        sheets_to_process <- unique(sheets_to_process)
      }
      
      new_data <- data.frame()
      for (sh in sheets_to_process) {
        df_sheet <- tryCatch({
          process_sheet(input$file_upload$datapath, sh)
        }, error = function(e) {
          showNotification(paste("⚠️ Failed to process sheet:", sh), type = "error")
          return(NULL)
        })
        
        if (!is.null(df_sheet) && nrow(df_sheet) > 0) {
          new_data <- bind_rows(new_data, df_sheet)
        }
      }
      
      if (nrow(new_data) == 0) {
        removeNotification(notification_id)
        showNotification("⚠️ No data found in uploaded file.", type = "warning")
        return(NULL)
      }
      
      colnames(new_data) <- c("USER ID", "NAME", "DEPARTMENT", "DATE", "TIME IN", "TIME OUT")
      
      new_data <- new_data[!apply(new_data, 1, function(r) all(is.na(r) | r == "")), ]
      
      new_data_unique <- distinct(new_data)
      
      if (nrow(new_data_unique) == 0) {
        removeNotification(notification_id)
        showNotification("⚠️ No new data to upload.", type = "warning")
        return(NULL)
      }
      
      key_cols <- c("USER ID", "NAME", "DEPARTMENT", "DATE", "TIME IN", "TIME OUT")
      
      if (nrow(existing_df) > 0) {
        rows_to_upload <- anti_join(new_data_unique, existing_df, by = key_cols)
      } else {
        rows_to_upload <- new_data_unique
      }
      
      if (nrow(rows_to_upload) == 0) {
        removeNotification(notification_id)
        showNotification("⚠️ All rows already exist in the data. No new data uploaded.", type = "warning")
        return(NULL)
      }
      
      rows_to_upload <- rows_to_upload %>%
        mutate(
          `HOURS RENDERED` = round(as.numeric(difftime(as.POSIXct(`TIME OUT`, format = "%H:%M"),
                                                       as.POSIXct(`TIME IN`, format = "%H:%M"), units = "hours")), 2),
          `HOURS RENDERED` = ifelse(is.na(`HOURS RENDERED`), 0, `HOURS RENDERED`),
          STATUS = case_when(
            `HOURS RENDERED` == 0 ~ "NO TIME RENDERED",
            `HOURS RENDERED` > 0 & `HOURS RENDERED` < 6 ~ "UNDERTIME",
            `HOURS RENDERED` >= 6 & `HOURS RENDERED` <= 8 ~ "NORMAL",
            `HOURS RENDERED` > 8 ~ "OVERTIME",
            TRUE ~ "NO TIME RENDERED"
          )
        )
      
      combined <- bind_rows(existing_df, rows_to_upload) %>%
        distinct(across(all_of(key_cols)), .keep_all = TRUE)
      
      attendance_data(combined)
      write.csv(combined, "data/updated_attendance.csv", row.names = FALSE)
      
      removeNotification(notification_id)
      showNotification("✅ Attendance Log uploaded successfully.", type = "message")
      
    }, error = function(e) {
      removeNotification(notification_id)
      showNotification("⚠️ Upload failed.", type = "error")
    })
  })
  
  #Renders data table 
  output$editable_table <- renderDT({
    df <- attendance_data()
    req(df)
    
    datatable(
      df,
      filter = "top",
      extensions = c('FixedColumns'),
      selection = list(mode = "multiple"),
      options = list(
        scrollX = TRUE,
        scrollY = "400px",
        scrollCollapse = TRUE,
        lengthMenu = list(c(10, 25, 50, 100, -1), c("10", "25", "50", "100", "All")),
        fixedColumns = list(leftColumns = 3)
      )
    )
  })
  
  #Observer for when the table is edited
  observeEvent(input$editable_table_cell_edit, {
    info <- input$editable_table_cell_edit
    df <- attendance_data()
    
    # Update the data frame
    df[info$row, info$col] <- info$value
    attendance_data(df)
    
    # Save to CSV
    write.csv(df, "data/updated_attendance.csv", row.names = FALSE)
  })
  
  #Save changes button observer
  observeEvent(input$save_changes, {
    req(attendance_data())
    df <- attendance_data()
    write.csv(df, "data/updated_attendance.csv", row.names = FALSE)
    showNotification("💾 Changes saved successfully.", type = "message")
  })
  
  
  # Handle Select All
  observeEvent(input$select_all, {
    df <- attendance_data()
    if (!is.null(df)) {
      proxy <- dataTableProxy("editable_table")
      selectRows(proxy, seq_len(nrow(df)))
    }
  })
  
  #Handle Deselect All
  observeEvent(input$deselect_all, {
    proxy <- dataTableProxy("editable_table")
    selectRows(proxy, NULL)
  })
  
  #ReactiveVal selecting current page button
  selected_rows <- reactiveVal(integer(0))
  observeEvent(input$select_current_page, {
    req(attendance_data())
    
    proxy <- dataTableProxy("editable_table")
    current_selection <- selected_rows()
    current_page_rows <- input$editable_table_rows_current
    
    # Combine previous selections with new ones and remove duplicates
    updated_selection <- sort(unique(c(current_selection, current_page_rows)))
    selected_rows(updated_selection)
    
    # Update the selection in the DataTable
    selectRows(proxy, updated_selection)
    
    showNotification(paste(length(current_page_rows), "row(s) selected on this page."), type = "message")
  })
  
  #Observer of delete row button 
  observeEvent(input$delete_row, {
    req(attendance_data())
    selected <- input$editable_table_rows_selected
    if (length(selected) == 0) {
      showNotification("⚠️ Please select at least one row to delete.", type = "error")
      return()
    }
    df <- attendance_data()
    undo_stack(df)
    df <- df[-selected, , drop = FALSE]
    attendance_data(df)
    write.csv(df, file = "data/updated_attendance.csv", row.names = FALSE)
    showNotification("🗑️ Selected row(s) deleted and saved.", type = "message")
  })
  
  #Observer of undo delete button 
  observeEvent(input$undo_delete, {
    prev <- undo_stack()
    if (is.null(prev)) {
      showNotification("❗ No recent delete action to undo.", type = "warning")
    } else {
      attendance_data(prev)
      write.csv(prev, file = "data/updated_attendance.csv", row.names = FALSE)
      undo_stack(NULL)
      showNotification("✅ Last delete undone.", type = "message")
    }
  })
  
  #Output for downloading editable table 
  output$download_log <- downloadHandler(
    filename = function() {
      ext <- ifelse(input$download_format == "SQL", ".sql", ".xlsx")
      paste0("current_attendance_", Sys.Date(), ext)
    },
    content = function(file) {
      df <- attendance_data()
      
      if (input$download_format == "Excel") {
        writexl::write_xlsx(df, path = file)
      } else {
        table_name <- "attendance_log"
        sql_statements <- paste0(
          "INSERT INTO ", table_name, " (", 
          paste(names(df), collapse = ", "), 
          ") VALUES ",
          paste(apply(df, 1, function(row) {
            paste0("('", paste(gsub("'", "''", row), collapse = "', '"), "')")
          }), collapse = ",\n"),
          ";"
        )
        writeLines(sql_statements, file)
      }
    }
  )
  
  #Handles Download only selected rows from the table
  output$download_selected <- downloadHandler(
    filename = function() {
      ext <- ifelse(input$download_format == "SQL", ".sql", ".xlsx")
      paste0("selected_attendance_", Sys.Date(), ext)
    },
    content = function(file) {
      df <- attendance_data()
      selected_rows <- input$editable_table_rows_selected
      
      if (length(selected_rows) == 0) {
        showNotification("⚠️ No rows selected. Download will be empty.", type = "warning")
        df <- data.frame(Note = "No rows selected")
      } else {
        df <- df[selected_rows, ]
      }
      
      if (input$download_format == "Excel") {
        writexl::write_xlsx(df, path = file)
      } else {
        # Write as a simple SQL INSERT script
        table_name <- "attendance_log"
        sql_statements <- paste0(
          "INSERT INTO ", table_name, " (", 
          paste(names(df), collapse = ", "), 
          ") VALUES ",
          paste(apply(df, 1, function(row) {
            paste0("('", paste(gsub("'", "''", row), collapse = "', '"), "')")
          }), collapse = ",\n"),
          ";"
        )
        writeLines(sql_statements, con = file)
      }
    }
  )
  
  #SERVICE CREDIT OBERVERS OUTPUTS, AND HANDLERS
  creds_uploaded_data <- reactiveVal()
  creds_undo_stack <- reactiveVal(NULL)
  creds_expiration_date <- reactiveVal(NULL)
  
  if (!dir.exists("data")) dir.create("data")
  
  if (file.exists("data/creds_updated_log.csv")) {
    if (file.exists("data/credit_expiration_date.txt")) {
      saved_date <- as.Date(readLines("data/credit_expiration_date.txt"))
      creds_expiration_date(saved_date)
      
      updateDateInput(session, "local_credit_expiry", value = as.character(saved_date))
    } else {
      updateDateInput(session, "local_credit_expiry", value = as.character(Sys.Date()))
    }
    
    saved_df <- read.csv("data/creds_updated_log.csv", stringsAsFactors = FALSE)
    
    saved_df <- saved_df[, !names(saved_df) %in% c("X1", "X__1", "Unnamed: 0")]
    saved_df <- saved_df[, !grepl("\\.1$", names(saved_df))]
    names(saved_df) <- trimws(toupper(names(saved_df)))
    
    if ("LOCAL SERVICE CREDITS" %in% names(saved_df)) {
      saved_df$`LOCAL.SERVICE.CREDITS` <- as.numeric(saved_df$`LOCAL.SERVICE.CREDITS`)
    }
    if ("NATIONAL SERVICE CREDITS" %in% names(saved_df)) {
      saved_df$`NATIONAL.SERVICE.CREDITS` <- as.numeric(saved_df$`NATIONAL.SERVICE.CREDITS`)
    }
    if (nrow(saved_df) > 0 && all(c("LOCAL.SERVICE.CREDITS", "NATIONAL.SERVICE.CREDITS") %in% names(saved_df))) {
      saved_df$`TOTAL.SERVICE.CREDITS` <- saved_df$`LOCAL.SERVICE.CREDITS` + saved_df$`NATIONAL.SERVICE.CREDITS`
    }
    
    creds_uploaded_data(saved_df)
  }
  
  # Render current expiry date
  output$current_expiry_date <- renderText({
    req(creds_expiration_date()) 
    paste("Current Expiry Date:", format(creds_expiration_date(), "%Y-%m-%d")) 
  })
  
  #Observer for file upload
  observeEvent(input$creds_file_upload, {
    req(input$creds_file_upload)
    
    ext <- tools::file_ext(input$creds_file_upload$name)
    validate(need(ext %in% c("xls", "xlsx"), "Please upload a valid Excel file."))
    
    new_df <- read_excel(input$creds_file_upload$datapath)
    
    col_names <- names(new_df)
    col_names_lower <- tolower(trimws(col_names))
    
    # Define target headers (case-insensitive)
    target_headers <- c(
      "EMPLOYEE.NAME",
      "EMPLOYEE.NUMBER",
      "DEPARTMENT",
      "LOCAL.SERVICE.CREDITS",
      "NATIONAL.SERVICE.CREDITS"
    )
    target_headers_lower <- tolower(target_headers)
    
    matched_cols <- sapply(target_headers_lower, function(th) {
      match_idx <- which(col_names_lower == th)
      if (length(match_idx) == 1) {
        return(match_idx)
      } else {
        return(NA)
      }
    })
    
    if (any(is.na(matched_cols))) {
      missing_cols <- target_headers[which(is.na(matched_cols))]
      showNotification(paste("Missing columns:", paste(missing_cols, collapse = ", ")), type = "error")
      return()
    }
    
    new_df_subset <- new_df[, matched_cols, drop = FALSE]
    names(new_df_subset) <- target_headers
    
    # Convert local and national service credits to numeric if they exist
    if ("LOCAL.SERVICE.CREDITS" %in% names(new_df_subset)) {
      new_df_subset$`LOCAL.SERVICE.CREDITS` <- as.numeric(new_df_subset$`LOCAL.SERVICE.CREDITS`)
    }
    if ("NATIONAL.SERVICE.CREDITS" %in% names(new_df_subset)) {
      new_df_subset$`NATIONAL.SERVICE.CREDITS` <- as.numeric(new_df_subset$`NATIONAL.SERVICE.CREDITS`)
    }
    
    # Check for required columns
    required_columns <- c("EMPLOYEE.NAME", "EMPLOYEE.NUMBER", "DEPARTMENT")
    if (all(required_columns %in% names(new_df_subset))) {
      new_df_subset <- new_df_subset[!duplicated(new_df_subset[required_columns]), ]
      
      existing_df <- creds_uploaded_data()
      if (!is.null(existing_df) && nrow(existing_df) > 0) {
        combined_df <- dplyr::bind_rows(existing_df, new_df_subset)
        
        unique_combined <- dplyr::distinct(combined_df, EMPLOYEE.NAME, EMPLOYEE.NUMBER, DEPARTMENT, .keep_all = TRUE)
        
        total_new_rows <- nrow(new_df_subset)
        retained_new_rows <- nrow(unique_combined) - (ifelse(is.null(existing_df), 0, nrow(existing_df)))
        duplicates <- total_new_rows - retained_new_rows
        if (duplicates > 0) {
          showNotification(paste(duplicates, "duplicate row(s) were skipped based on EMPLOYEE.NAME, EMPLOYEE.NUMBER, and DEPARTMENT."), type = "warning")
        }
        
        creds_uploaded_data(unique_combined)
      } else {
        creds_uploaded_data(new_df_subset)
      }
      
      # Reset undo stack
      creds_undo_stack(NULL)
      
      showNotification("✅ Excel file uploaded successfully.", type = "message")
    } else {
      showNotification("Required columns missing in the uploaded file.", type = "error")
    }
  })
  
  #Observer for when the system date reached the expiry date set
  observe({
    req(creds_uploaded_data())
    exp_date <- creds_expiration_date()
    
    if (!is.null(exp_date) && Sys.Date() >= exp_date) {
      df <- creds_uploaded_data()
      
      if (any(df$LOCAL.SERVICE.CREDITS != 0)) {
        df$LOCAL.SERVICE.CREDITS <- 0
        df$TOTAL.SERVICE.CREDITS <- df$LOCAL.SERVICE.CREDITS + df$NATIONAL.SERVICE.CREDITS
        
        creds_uploaded_data(df)
        write.csv(df, "data/creds_updated_log.csv", row.names = FALSE)
        
        showNotification("🕒 Local Service Credits have expired and set to 0.", type = "warning")
      }
    }
  })
  
  # Save expiry date when button is pressed
  observeEvent(input$save_credit_expiry, {
    req(input$local_credit_expiry)  
    new_expiry_date <- as.Date(input$local_credit_expiry)
    creds_expiration_date(new_expiry_date) 
    writeLines(as.character(new_expiry_date), "data/credit_expiration_date.txt") 
  })
  
  
  # Handling cell edits to update the total service credit
  observeEvent(input$creds_editable_table_cell_edit, {
    info <- input$creds_editable_table_cell_edit
    req(info)
    
    df <- creds_uploaded_data()
    
    row <- info$row
    col <- info$col
    col_name <- colnames(df)[col]
    
    # Only update if user edited a valid editable column (LOCAL.SERVICE.CREDIT or NATIONAL.SERVICE.CREDIT)
    if (col_name %in% c("LOCAL.SERVICE.CREDITS", "NATIONAL.SERVICE.CREDITS")) {
      new_value <- suppressWarnings(as.numeric(info$value))  
      if (!is.na(new_value)) {
        df[row, col] <- new_value
        
        # Recompute the total service credit
        df$`TOTAL.SERVICE.CREDITS`[row] <- 
          as.numeric(df$`LOCAL.SERVICE.CREDITS`[row]) + 
          as.numeric(df$`NATIONAL.SERVICE.CREDITS`[row])
        
        creds_uploaded_data(df) 
        
        write.csv(df, "data/creds_updated_log.csv", row.names = FALSE)
      } else {
        showNotification("⚠️ Please enter a valid number.", type = "error")
      }
    }
  })
  
  
  #Observer for Saving changes made in the Service Credit Editable table
  observeEvent(input$creds_save_changes, {
    req(creds_uploaded_data())
    df <- creds_uploaded_data()
    
    df$`TOTAL.SERVICE.CREDITS` <- as.numeric(df$`LOCAL.SERVICE.CREDITS`) + as.numeric(df$`NATIONAL.SERVICE.CREDITS`)
    
    write.csv(df, "data/creds_updated_log.csv", row.names = FALSE)
    creds_uploaded_data(df)  
    
    showNotification("✅ Service Credit Log Updated Successfully!", type = "message")
  })
  
  # Render the DataTable
  output$creds_editable_table <- renderDT({
    req(creds_uploaded_data()) 
    df <- creds_uploaded_data()
    
    locked_cols <- c("EMPLOYEE.NAME", 
                     "EMPLOYEE.NUMBER", 
                     "DEPARTMENT", 
                     "POSITION", 
                     "TOTAL.SERVICE.CREDITS")
    
    datatable(
      df,
      filter = "top",
      editable = list(target = "cell", disable = list(columns = which(names(df) %in% locked_cols))),
      extensions = c('FixedColumns'),
      selection = list(mode = "multiple", target = "row"),
      options = list(
        scrollX = TRUE,                         
        scrollY = "400px",                      
        scrollCollapse = TRUE,                   
        pageLength = input$creds_rows_per_page,
        lengthMenu = list(c(10, 25, 50, 100, -1), c("10", "25", "50", "100", "All")),
        fixedColumns = list(leftColumns = 3),
        initComplete = JS(
          "function(settings, json) {",
          "  $(this.api().table().container()).find('.dataTables_scrollBody').css({'overflow-x': 'auto'});",
          "}"
        ),
        dom = 'frtip'
      )
    )
  })
  
  # Handle Select All
  observeEvent(input$creds_select_all, {
    df <- creds_uploaded_data()
    if (!is.null(df)) {
      proxy <- dataTableProxy("creds_editable_table")
      selectRows(proxy, seq_len(nrow(df)))
    }
  })
  
  # Handle Deselect All
  observeEvent(input$creds_deselect_all, {
    proxy <- dataTableProxy("creds_editable_table")
    selectRows(proxy, NULL)
  })
  
  #ReactiveVal for selected rows
  creds_selected_rows <- reactiveVal(integer(0))
  observeEvent(input$creds_select_current_page, {
    req(creds_uploaded_data())
    
    proxy <- dataTableProxy("creds_editable_table")
    current_selection <- creds_selected_rows()
    current_page_rows <- input$creds_editable_table_rows_current
    
    updated_selection <- sort(unique(c(current_selection, current_page_rows)))
    creds_selected_rows(updated_selection)
    
    selectRows(proxy, updated_selection)
    
    showNotification(paste(length(current_page_rows), "row(s) selected on this page."), type = "message")
  })
  
  #Observe event of delete row button 
  observeEvent(input$creds_delete_row, {
    req(creds_uploaded_data())
    selected <- input$creds_editable_table_rows_selected
    if (length(selected) == 0) {
      showNotification("⚠️ Please select at least one row to delete.", type = "error")
      return()
    }
    df <- creds_uploaded_data()
    creds_undo_stack(df)
    df <- df[-selected, , drop = FALSE]
    creds_uploaded_data(df)
    write.csv(df, file = "data/creds_updated_log.csv", row.names = FALSE)
    showNotification("🗑️ Selected row(s) deleted and saved.", type = "message")
  })
  
  #Observe event of undo delete button 
  observeEvent(input$creds_undo_delete, {
    prev <- creds_undo_stack()
    if (is.null(prev)) {
      showNotification("❗ No recent delete action to undo.", type = "warning")
    } else {
      creds_uploaded_data(prev)
      write.csv(prev, file = "data/creds_updated_log.csv", row.names = FALSE)
      undo_stack(NULL)
      showNotification("✅ Last delete undone.", type = "message")
    }
  })
  
  #Output for downloading current log
  output$creds_download_log <- downloadHandler(
    filename = function() {
      ext <- ifelse(input$creds_download_format == "SQL", ".sql", ".xlsx")
      paste0("current_service_credit_log_", Sys.Date(), ext)
    },
    content = function(file) {
      df <- creds_uploaded_data()  
      
      if (input$creds_download_format == "Excel") {
        writexl::write_xlsx(df, path = file)
      } else {
        table_name <- "service_credit_log"
        sql_statements <- paste0(
          "INSERT INTO ", table_name, " (", 
          paste(names(df), collapse = ", "), 
          ") VALUES ",
          paste(apply(df, 1, function(row) {
            paste0("('", paste(gsub("'", "''", row), collapse = "', '"), "')")
          }), collapse = ",\n"),
          ";"
        )
        writeLines(sql_statements, file)
      }
    }
  )
  
  #Download only selected rows from the table
  output$creds_download_selected <- downloadHandler(
    filename = function() {
      ext <- ifelse(input$creds_download_format == "SQL", ".sql", ".xlsx")
      paste0("selected_service_credit_", Sys.Date(), ext)
    },
    content = function(file) {
      df <- creds_uploaded_data() 
      selected_rows <- input$creds_editable_table_rows_selected 
      
      if (length(selected_rows) == 0) {
        showNotification("⚠️ No rows selected. Download will be empty.", type = "warning")
        df <- data.frame(Note = "No rows selected")o
      } else {
        df <- df[selected_rows, ]  
      }
      
      if (input$creds_download_format == "Excel") {
        writexl::write_xlsx(df, path = file)
      } else {
        table_name <- "service_credit_log"
        sql_statements <- paste0(
          "INSERT INTO ", table_name, " (", 
          paste(names(df), collapse = ", "), 
          ") VALUES ",
          paste(apply(df, 1, function(row) {
            paste0("('", paste(gsub("'", "''", row), collapse = "', '"), "')")
          }), collapse = ",\n"),
          ";"
        )
        writeLines(sql_statements, con = file)
      }
    }
  )
  
  #TEACHER PROFILE HANDLERS AND OBSERVERS 
  prof_uploaded_data <- reactiveVal()
  prof_undo_stack <- reactiveVal(NULL)
  
  if (!dir.exists("data")) dir.create("data")
  
  if (file.exists("data/updated_profile.csv")) {
    saved_df <- read.csv("data/updated_profile.csv", stringsAsFactors = FALSE)
    saved_df <- saved_df[, !names(saved_df) %in% c("X1", "X__1", "Unnamed: 0")]
    saved_df <- saved_df[, !grepl("\\.1$", names(saved_df))]
    names(saved_df) <- trimws(toupper(names(saved_df)))
    prof_uploaded_data(as.data.frame(lapply(saved_df, as.character)))
  }
  
  #Observer for file upload
  observeEvent(input$prof_file_upload, {
    req(input$prof_file_upload)
    
    ext <- tools::file_ext(input$prof_file_upload$name)
    if (!ext %in% c("xls", "xlsx")) {
      showNotification("❌ Please upload a valid Excel file (.xls or .xlsx).", type = "error")
      return()
    }
    
    new_df <- read_excel(input$prof_file_upload$datapath)
    
    new_df <- new_df[, !names(new_df) %in% c("X1", "X__1", "Unnamed: 0")]
    new_df <- new_df[, !grepl("\\.1$", names(new_df))]
    names(new_df) <- trimws(toupper(names(new_df)))
    
    required_cols <- c("NAME", "POSITION", "EMPLOYEE NUMBER", 
                       "ORIGINAL DATE OF APPOINTMENT", 
                       "RECLASS/PROMOTION DATE OF APPOINTMENT", 
                       "BIRTHDAY")
    
    missing_cols <- setdiff(required_cols, names(new_df))
    if (length(missing_cols) > 0) {
      showNotification(paste("⚠️ Missing required column(s):", paste(missing_cols, collapse = ", ")), type = "error")
      return()
    }
    
    new_df <- new_df[, required_cols, drop = FALSE]
    
    # Format date columns
    date_cols <- c("ORIGINAL DATE OF APPOINTMENT", "RECLASS/PROMOTION DATE OF APPOINTMENT", "BIRTHDAY")
    for (col in date_cols) {
      if (col %in% names(new_df)) {
        new_df[[col]] <- format(as.Date(new_df[[col]], format="%Y-%m-%d"), "%m/%d/%Y")
      }
    }
    
    # Compute YEARS.OF.SERVICE
    if ("ORIGINAL DATE OF APPOINTMENT" %in% names(new_df)) {
      new_df$`ORIGINAL DATE OF APPOINTMENT` <- as.Date(new_df$`ORIGINAL DATE OF APPOINTMENT`, format = "%m/%d/%Y")
      appointment_month_day <- format(new_df$`ORIGINAL DATE OF APPOINTMENT`, "%m-%d")
      current_date <- Sys.Date()
      current_month_day <- format(current_date, "%m-%d")
      years_service <- floor(as.numeric(difftime(current_date, new_df$`ORIGINAL DATE OF APPOINTMENT`, units = "days")) / 365.25)
      years_service <- ifelse(appointment_month_day > current_month_day, years_service, years_service)
      new_df$`YEARS.OF.SERVICE` <- as.character(years_service)
      new_df$`ORIGINAL DATE OF APPOINTMENT` <- format(new_df$`ORIGINAL DATE OF APPOINTMENT`, "%m/%d/%Y")
    }
    
    existing_df <- prof_uploaded_data()
    
    if (!is.null(existing_df) && nrow(existing_df) > 0) {
      common_cols <- intersect(names(existing_df), names(new_df))
      existing_subset <- existing_df[, common_cols]
      new_subset <- new_df[, common_cols]
      
      for (col in common_cols) {
        if (col %in% names(existing_subset) && col %in% names(new_subset)) {
          existing_subset[[col]] <- as.character(existing_subset[[col]])
          new_subset[[col]] <- as.character(new_subset[[col]])
        }
      }
      
      combined_df <- dplyr::bind_rows(existing_subset, new_subset)
      unique_combined <- dplyr::distinct(combined_df)
      
      total_new_rows <- nrow(new_df)
      retained_new_rows <- nrow(unique_combined) - nrow(existing_df)
      duplicates <- total_new_rows - retained_new_rows
      
      non_duplicates <- tail(unique_combined, retained_new_rows)
      
      if (retained_new_rows > 0) {
        prof_uploaded_data(dplyr::bind_rows(existing_df, non_duplicates))
        showNotification(paste("✅", retained_new_rows, "row(s) successfully added."), type = "message")
      }
      
      if (duplicates > 0) {
        showNotification(paste("⚠️", duplicates, "duplicate row(s) found and skipped."), type = "warning")
      }
      
      if (retained_new_rows == 0) {
        showNotification("⚠️ All uploaded rows are duplicates. No new data added.", type = "warning")
      }
      
    } else {
      new_df[] <- lapply(new_df, as.character)
      prof_uploaded_data(new_df)
      showNotification("✅ Excel file uploaded successfully.", type = "message")
    }
    
    write.csv(prof_uploaded_data(), file = "data/updated_profile.csv", row.names = FALSE)
  })
  
  #Output for editing table
  output$prof_editable_table <- renderDT({
    req(prof_uploaded_data())
    df <- prof_uploaded_data()
    
    locked_cols <- c("NAME", 
                     "EMPLOYEE.NUMBER", "EMPLOYEE NUMBER",
                     "POSITION",
                     "ORIGINAL.DATE.OF.APPOINTMENT", 
                     "ORIGINAL DATE OF APPOINTMENT",
                     "RECLASS/PROMOTION DATE OF APPOINTMENT", 
                     "RECLASS.PROMOTION.DATE.OF.APPOINTMENT",
                     "BIRTHDAY", "YEARS.OF.SERVICE")
    
    datatable(
      df,
      filter = "top",
      editable = list(target = "cell", disable = list(columns = which(names(df) %in% locked_cols))),
      selection = list(mode = "multiple", target = "row"),
      extensions = c('Buttons', 'FixedColumns'),
      options = list(
        scrollX = TRUE,
        scrollY = "400px",
        scrollCollapse = TRUE,
        pageLength = input$prof_rows_per_page,
        lengthMenu = list(c(10, 25, 50, 100, -1), c("10", "25", "50", "100", "All")),
        fixedColumns = list(leftColumns = 2),
        dom = 'frtip'
      )
    )
  })
  
  #Obsever for when the data is edited
  observeEvent(input$prof_editable_table_cell_edit, {
    info <- input$prof_editable_table_cell_edit
    df <- prof_uploaded_data()
    df[info$row, info$col] <- info$value
    prof_uploaded_data(df)
  })
  
  # Handle Select All
  observeEvent(input$prof_select_all, {
    df <- prof_uploaded_data()
    if (!is.null(df)) {
      proxy <- dataTableProxy("prof_editable_table")
      selectRows(proxy, seq_len(nrow(df)))
    }
  })
  
  # Handle Deselect All
  observeEvent(input$prof_deselect_all, {
    proxy <- dataTableProxy("prof_editable_table")
    selectRows(proxy, NULL)
  })
  
  #Observer for selecting current page button
  prof_selected_rows <- reactiveVal(integer(0))
  
  observeEvent(input$prof_select_current_page, {
    req(prof_uploaded_data())
    
    proxy <- dataTableProxy("prof_editable_table")
    current_selection <- prof_selected_rows()
    current_page_rows <- input$prof_editable_table_rows_current
    
    updated_selection <- sort(unique(c(current_selection, current_page_rows)))
    selected_rows(updated_selection)
    
    selectRows(proxy, updated_selection)
    
    showNotification(paste(length(current_page_rows), "row(s) selected on this page."), type = "message")
  })
  
  #Observer for Saving changes made in the Attendance Editable table
  observeEvent(input$prof_save_changes, {
    req(prof_uploaded_data())
    df <- prof_uploaded_data()
    
    write.csv(df, file = "data/updated_profile.csv", row.names = FALSE)
    showNotification("✅ Teacher Profile saved successfully.", type = "message")
  })
  
  #Observe event of delete row button 
  observeEvent(input$prof_delete_row, {
    req(prof_uploaded_data())
    selected <- input$prof_editable_table_rows_selected
    if (length(selected) == 0) {
      showNotification("⚠️ Please select at least one row to delete.", type = "error")
      return()
    }
    df <- prof_uploaded_data()
    prof_undo_stack(df)
    df <- df[-selected, , drop = FALSE]
    prof_uploaded_data(df)
    write.csv(df, file = "data/updated_profile.csv", row.names = FALSE)
    showNotification("🗑️ Selected row(s) deleted and saved.", type = "message")
  })
  
  #Observe event of undo delete button 
  observeEvent(input$prof_undo_delete, {
    prev <- prof_undo_stack()
    if (is.null(prev)) {
      showNotification("❗ No recent delete action to undo.", type = "warning")
    } else {
      uploaded_data(prev)
      write.csv(prev, file = "data/updated_profile.csv", row.names = FALSE)
      prof_undo_stack(NULL)
      showNotification("✅ Last delete undone.", type = "message")
    }
  })
  
  #Output for downloading editable table 
  output$prof_download_log <- downloadHandler(
    filename = function() {
      ext <- ifelse(input$prof_download_format == "SQL", ".sql", ".xlsx")
      paste0("current_teacher_profile", Sys.Date(), ext)
    },
    content = function(file) {
      df <- uploaded_data()
      
      if (input$download_format == "Excel") {
        writexl::write_xlsx(df, path = file)
      } else {
        table_name <- "teacher_profile"
        sql_statements <- paste0(
          "INSERT INTO ", table_name, " (", 
          paste(names(df), collapse = ", "), 
          ") VALUES ",
          paste(apply(df, 1, function(row) {
            paste0("('", paste(gsub("'", "''", row), collapse = "', '"), "')")
          }), collapse = ",\n"),
          ";"
        )
        writeLines(sql_statements, file)
      }
    }
  )
  
  
  #Download only selected rows from the table
  output$prof_download_selected <- downloadHandler(
    filename = function() {
      ext <- ifelse(input$prof_download_format == "SQL", ".sql", ".xlsx")
      paste0("prof_selected_attendance_", Sys.Date(), ext)
    },
    content = function(file) {
      df <- prof_uploaded_data()
      prof_selected_rows <- input$prof_editable_table_rows_selected
      
      if (length(selected_rows) == 0) {
        showNotification("⚠️ No rows selected. Download will be empty.", type = "warning")
        df <- data.frame(Note = "No rows selected")
      } else {
        df <- df[prof_selected_rows, ]
      }
      
      if (input$prof_download_format == "Excel") {
        writexl::write_xlsx(df, path = file)
      } else {
        
        table_name <- "teacher_profile"
        sql_statements <- paste0(
          "INSERT INTO ", table_name, " (", 
          paste(names(df), collapse = ", "), 
          ") VALUES ",
          paste(apply(df, 1, function(row) {
            paste0("('", paste(gsub("'", "''", row), collapse = "', '"), "')")
          }), collapse = ",\n"),
          ";"
        )
        writeLines(sql_statements, con = file)
      }
    }
  )
  
  #OVERVIEW HANDLERS, OUTPUTS, OBSERVERS
  total_teachers <- reactive({
    req(attendance_data())
    attendance_data() %>% pull(`USER.ID`) %>% unique() %>% length()
  })
  
  #Observer for the attendance data
  observeEvent(attendance_data(), {
    req(attendance_data())
    
    available_dates <- unique(attendance_data()$DATE)
    
    if (!inherits(available_dates, "Date")) {
      available_dates <- as.Date(available_dates)
    }
    
    if (length(available_dates) > 0 && !is.null(input$attendance_date) && length(input$attendance_date) == 1) {
      if (!(input$attendance_date %in% available_dates)) {
        updateDateInput(session, "attendance_date", value = max(available_dates))
      }
    }
  })
  
  
  filtered_attendance <- reactive({
    req(attendance_data(), input$attendance_date)
    
    data <- attendance_data()
    
    if (!inherits(data$DATE, "Date")) {
      data$DATE <- as.Date(data$DATE)
    }
    
    data %>%
      filter(DATE == input$attendance_date)
  })
  
  #Rendering of the box
  output$normal_hours_ui <- renderUI({
    n_status <- nrow(filtered_attendance() %>% filter(STATUS == "NORMAL"))
    total_teachers <- total_teachers()
    date <- input$attendance_date
    percent <- if (total_teachers > 0) round((n_status / total_teachers) * 100, 1) else 0
    
    div(class = "hover-box",
        div(class = "box front-box bg-green",
            tags$div(class = "inner",
                     tags$h3(n_status),
                     tags$p(paste0("out of ", total_teachers(), " teachers rendered 6-8 hours"))
                     
            ),
            tags$div(class = "icon", icon("clock"))
        ),
        div(class = "box back-box bg-green",
            tags$div(class = "inner",
                     tags$h3(paste0(percent, "%")),
                     tags$p(paste0(percent, "% of teachers are tagged as NORMAL on ", date))
            ),
            tags$div(class = "icon", icon("clock"))
        )
    )
  })
  
  #Rendering of the box
  output$overtime_ui <- renderUI({
    n_status <- nrow(filtered_attendance() %>% filter(STATUS == "OVERTIME"))
    total_teachers <- total_teachers()
    date <- input$attendance_date
    percent <- if (total_teachers > 0) round((n_status / total_teachers) * 100, 1) else 0
    
    div(class = "hover-box",
        div(class = "box front-box bg-blue",
            tags$div(class = "inner",
                     tags$h3(n_status),
                     tags$p(paste0("out of ", total_teachers(), " teachers rendered >8 hours"))
                     
            ),
            tags$div(class = "icon", icon("plus-circle"))
        ),
        div(class = "box back-box bg-blue",
            tags$div(class = "inner",
                     tags$h3(paste0(percent, "%")),
                     tags$p(paste0(percent, "% of teachers tagged as OVERTIME on ", date))
            ),
            tags$div(class = "icon", icon("plus-circle"))
        )
    )
  })
  
  #Rendering of the box
  output$undertime_ui <- renderUI({
    n_status <- nrow(filtered_attendance() %>% filter(STATUS == "UNDERTIME"))
    total_teachers <- total_teachers()
    date <- input$attendance_date
    percent <- if (total_teachers > 0) round((n_status / total_teachers) * 100, 1) else 0
    
    div(class = "hover-box",
        div(class = "box front-box bg-orange",
            tags$div(class = "inner",
                     tags$h3(n_status),
                     tags$p(paste0("out of ", total_teachers(), " teachers rendered <6 hours"))
                     
            ),
            tags$div(class = "icon", icon("minus-circle"))
        ),
        div(class = "box back-box bg-orange",
            tags$div(class = "inner",
                     tags$h3(paste0(percent, "%")),
                     tags$p(paste0(percent, "% of teachers are tagged as UNDERTIME on ", date))
            ),
            tags$div(class = "icon", icon("minus-circle"))
        )
    )
  })
  
  #Rendering of the box
  output$most_rendered_ui <- renderUI({
    req(max_min_employees())
    
    tags$div(
      class = "custom-box1",
      tags$h4("🏆 Highest Total Hours (MOnthly)"),
      tableOutput("most_rendered_table")
    )
  })
  
  #Rendering of the box
  output$least_rendered_ui <- renderUI({
    req(max_min_employees())
    
    tags$div(
      class = "custom-box1",
      tags$h4("📉 Lowest Total Hours (Monthly)"),
      tableOutput("least_rendered_table")
    )
  })
  
  #Rendering of the table
  output$most_rendered_table <- renderTable({
    req(max_min_employees())
    
    most <- max_min_employees()$most_rendered
    
    if (nrow(most) == 0) {
      return(data.frame(Message = "No data available."))
    }
    
    most %>%
      rename(
        `USER ID` = `USER.ID`,
        `NAME` = `NAME`,
        `TOTAL HOURS` = `TOTAL_HOURS`
      )
  }, striped = TRUE, bordered = TRUE, hover = TRUE)
  
  #Rendering of the table
  output$least_rendered_table <- renderTable({
    req(max_min_employees())
    
    least <- max_min_employees()$least_rendered
    
    if (nrow(least) == 0) {
      return(data.frame(Message = "No data available."))
    }
    
    least %>%
      rename(
        `USER ID` = `USER.ID`,
        `NAME` = `NAME`,
        `TOTAL HOURS` = `TOTAL_HOURS`
      )
  }, striped = TRUE, bordered = TRUE, hover = TRUE)
  
  #Handles birthday reminders in overview tab
  output$birthday_reminders_ui <- renderUI({
    today <- Sys.Date()
    data <- prof_uploaded_data()
    
    if (is.null(data) || nrow(data) == 0) {
      return(tags$p("No data available."))
    }
    
    upcoming_birthdays <- data %>%
      mutate(
        BIRTHDAY = as.Date(BIRTHDAY, format = "%m/%d/%Y")
      ) %>%
      filter(!is.na(BIRTHDAY)) %>%
      mutate(
        birthday_this_year = make_date(year(today), month(BIRTHDAY), day(BIRTHDAY)),
        next_birthday = if_else(birthday_this_year < today,
                                birthday_this_year + years(1),
                                birthday_this_year),
        days_until_birthday = as.integer(next_birthday - today),
        upcoming_age = year(today) - year(BIRTHDAY) + if_else(birthday_this_year < today, 1, 0)
      ) %>%
      filter(!is.na(NAME)) %>%
      arrange(days_until_birthday) %>%
      slice_head(n = 5)
    
    if (nrow(upcoming_birthdays) == 0) {
      return(tags$p("No birthdays on record."))
    }
    
    lapply(1:nrow(upcoming_birthdays), function(i) {
      name <- upcoming_birthdays$NAME[i]
      bday <- format(upcoming_birthdays$BIRTHDAY[i], "%B %d")
      age <- upcoming_birthdays$upcoming_age[i]
      days_left <- upcoming_birthdays$days_until_birthday[i]
      
      msg <- if (!is.na(days_left) && days_left == 0) {
        paste0("🎉 ", name, " turns ", age, " today!")
      } else {
        paste0("🎈 ", name, " will turn ", age, " on ", bday, " (in ", days_left, " day", ifelse(days_left > 1, "s", ""), ")")
      }
      
      div(class = "birthday-card", msg)
    })
  })
  
  #Handles service years reminder in overview
  output$service_anniversary_ui <- renderDT({
    data <- prof_uploaded_data()
    today <- Sys.Date()
    
    if (is.null(data) || nrow(data) == 0) {
      return(datatable(data.frame(Message = "No data available."), options = list(dom = 't')))
    }
    
    milestone_data <- data %>%
      mutate(
        APPOINTMENT_DATE = suppressWarnings(as.Date(
          if ("ORIGINAL.DATE.OF.APPOINTMENT" %in% colnames(data)) {
            .data$ORIGINAL.DATE.OF.APPOINTMENT
          } else if ("ORIGINAL DATE OF APPOINTMENT" %in% colnames(data)) {
            .data$`ORIGINAL DATE OF APPOINTMENT`
          } else {
            NA_character_
          },
          format = "%m/%d/%Y"
        ))
      ) %>%
      filter(!is.na(APPOINTMENT_DATE)) %>%
      mutate(
        MONTH_DAY = format(APPOINTMENT_DATE, "%m-%d"),   # ensures leading zeros
        NEXT_ANNIVERSARY = as.Date(paste0(year(today), "-", MONTH_DAY), format = "%Y-%m-%d"),
        NEXT_ANNIVERSARY = if_else(NEXT_ANNIVERSARY < today, NEXT_ANNIVERSARY + lubridate::years(1), NEXT_ANNIVERSARY),
        YEARS = as.integer(difftime(NEXT_ANNIVERSARY, APPOINTMENT_DATE, units = "days") / 365)
      ) %>%
      filter(NEXT_ANNIVERSARY %in% (today + 0:3)) %>%
      filter(YEARS %% 5 == 0, YEARS > 0) %>%
      arrange(NEXT_ANNIVERSARY) %>%
      select(NAME, APPOINTMENT_DATE, NEXT_ANNIVERSARY, YEARS)
    
    
    if (nrow(milestone_data) == 0) {
      return(datatable(data.frame(Message = "No upcoming service anniversaries."), options = list(dom = 't')))
    }
    
    datatable(
      milestone_data,
      rownames = FALSE,
      options = list(
        scrollX = TRUE,
        scrollY = "400px",
        scrollCollapse = TRUE,
        lengthMenu = list(c(10, 25, 50, 100, -1), c("10", "25", "50", "100", "All")),
        fixedColumns = list(leftColumns = 2),
        dom = 'frtip'
      )
    )
  })
  
  #Renders graph
  output$daily_attendance_count_plot <- renderPlot({
    req(attendance_data())
    
    data <- attendance_data() %>%
      mutate(DATE = as.Date(DATE)) %>%
      filter(DATE == input$attendance_date1)
    
    if (nrow(data) == 0) {
      attendance_summary <- data.frame(DEPARTMENT = factor(levels = unique(attendance_data()$DEPARTMENT)),
                                       Attendance_Count = numeric())
    } else {
      attendance_summary <- data %>%
        group_by(DEPARTMENT) %>%
        summarise(Attendance_Count = sum(HOURS.RENDERED > 0, na.rm = TRUE), .groups = 'drop')
    }
    
    ggplot(attendance_summary, aes(x = DEPARTMENT, y = Attendance_Count, fill = DEPARTMENT)) +
      geom_bar(stat = "identity") +
      scale_y_continuous(limits = c(0, 10), breaks = seq(0, 10, 2), expand = c(0, 0)) +
      labs(title = paste("Attendance Count by Department on", input$attendance_date1),
           x = "Department", y = "Number of Employees") +
      theme_minimal() +
      theme(
        legend.position = "none",
        panel.grid.major.y = element_line(color = "grey80"),
        panel.grid.minor.y = element_blank()
      )
  })
  
  #Renders graph
  output$avg_hours_worked_plot <- renderPlot({
    req(attendance_data())
    data <- attendance_data() %>%
      mutate(DATE = as.Date(DATE)) %>%
      filter(DATE >= input$attendance_date_range[1],
             DATE <= input$attendance_date_range[2])
    
    if (nrow(data) == 0) {
      avg_hours_summary <- data.frame(DEPARTMENT = factor(levels = unique(attendance_data()$DEPARTMENT)),
                                      Average_Hours = numeric())
    } else {
      avg_hours_summary <- data %>%
        group_by(DEPARTMENT, DATE) %>%
        summarise(Average_Hours = mean(HOURS.RENDERED, na.rm = TRUE), .groups = 'drop')
    }
    
    ggplot(avg_hours_summary, aes(x = DEPARTMENT, y = Average_Hours, fill = DEPARTMENT)) +
      geom_bar(stat = "identity") +
      scale_y_continuous(limits = c(0, 10), breaks = seq(0, 10, 2), expand = c(0, 0)) +
      labs(title = paste("Average Hours Worked per Department\n",
                         input$attendance_date_range[1], "to", input$attendance_date_range[2]),
           x = "Department", y = "Average Hours") +
      theme_minimal() +
      theme(
        legend.position = "none",
        panel.grid.major.y = element_line(color = "grey80"),
        panel.grid.minor.y = element_blank()
      )
  })
}  
# Running the app
shinyApp(ui = uiOutput("ui"), server = server)