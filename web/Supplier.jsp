
<%@page  import ="java.sql.*"%>
<%!
    public static Connection connect() {

        try {

            Class.forName("com.mysql.jdbc.Driver").newInstance();

            return DriverManager.getConnection("jdbc:mysql://localhost/stocdatabase", "root", "123456");
        } catch (Exception e) {
            return null;
        }

    }

    public static boolean close(Connection c) {
        try {
            c.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }


%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Supplier Information</title>
    </head>

    <body>
        <h1>Supplier List </h1>
        <% try {

                Connection c = connect();
                Statement stmt = c.createStatement();
                ResultSet rs = stmt.executeQuery("Select * from supplier");

        %>

        <% while (rs.next()) {%>
        <table border="1" style="width:100%"> <col width="100"> <col width="100"><col width="100"><col width="100"><col width="100">


            
                <tr>
                    <td><%out.println(rs.getString(1));%></td> 
                    <td><%out.println(rs.getString(2));%></td> 
                    <td><%out.println(rs.getString(3));%></td> 
                    <td><%out.println(rs.getString(4));%></td> 
                    <td><%out.println(rs.getString(5));%></td> 


                </tr>

           
        </table>  
        <%  }

                c.close();
            } catch (Exception e) {

            }%>


        <h1>Adding New Supplier</h1>



        <form name="name1" action="#" method="POST">
            <table border="1">


                <tr >
                    <td>Supplier Name :</td>
                    <td><input type="text" name="sname" value="" size="50" autocomplete="off"/></td>
                </tr>
                <tr>
                    <td>Supplier Email :</td>
                    <td><input type="text" name="semail" value="" size="50" autocomplete="off"/></td>
                </tr>
                <tr>
                    <td>Supplier phone :</td>
                    <td><input type="text" name="sphone" value="" size="50" autocomplete="off"/></td>
                </tr>
                 <tr>
                    <td>Supplier address :</td>
                    <td><input type="text" name="saddress" value="" size="50" autocomplete="off"/></td>
                </tr>
                
             <tr>
                    <td><input type="submit" value="Add" name="btnadd"/></td>
                    <td><input type="reset" value="Reset" name="btnreset" /></td>
                </tr>

            </table>
        </form>
        <%
            if (request.getMethod().equals("POST")) {
                String sname,semail, sphone, saddress;
                sname = request.getParameter("sname");
                semail = request.getParameter("semail");
                sphone = request.getParameter("sphone");
                saddress = request.getParameter("saddress");

                try {
                    Connection c = connect();

                    String sql = "insert into stocdatabase.supplier(SupplierName,SupplierEmail,Supplieraddress,Supplierphone)  values ('" + sname + "','"+semail+"','"+saddress+"','" + sphone + "')";

                    Statement stmt1 = c.createStatement();
                    stmt1.executeUpdate(sql);

                    c.close();

                } catch (Exception e) {
                    out.print(e.getMessage());
                }
            }

        %>        










    </body>
</html>
