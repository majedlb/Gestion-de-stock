
<%@page  import ="java.sql.*"%>
<%!
    public static Connection connect() {

        try {

            Class.forName("com.mysql.jdbc.Driver").newInstance();

            return DriverManager.getConnection("jdbc:mysql://localhost/stocdatabase", "root", "root");
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
        <title>Login Page</title>
    </head>
    <body>
        <h1>Stock Informations</h1>

        <form name="name1" action="#" method="POST">
            <%   try {
                    Connection c12 = connect();
                    Statement stmt12 = c12.createStatement();
                    ResultSet rs12 = stmt12.executeQuery("select s.stockid,s.Stockname,p.idproduct,p.productname,p.productQuantity,p.productmodel from stocdatabase.stock s,stocdatabase.stocpro sp,stocdatabase.product p where s.Stockid=sp.stocid and p.idproduct=sp.prodid1");%>
            <table border="1"> <col width="75"> <col width="100">
                <tr><td>Stock id </td><td>Stock Name</td></tr></table>
                <% while (rs12.next()) {%> 

            <table border="1"> <col width="75"> <col width="100">



                <tbody>
                    <tr>
                        <td><%out.println(rs12.getString(1));%></td> 
                        <td><%out.println(rs12.getString(2));%></td> 

                    </tr>

                </tbody>
            </table> 

            <%  }%>
            <br><%
                    c12.close();
                } catch (Exception e) {

                }
            %>






            <h1>Login Page</h1>

            <table border="1" >

                <tr>
                    <td>Employee username :</td>
                    <td><input type="text" name="eusername" value="" size="50" autocomplete="off"/></td>
                </tr>
                <tr>
                    <td>Employee Password</td>
                    <td><input type="text" name="epass" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td>Stock ID:</td><td>
                        <select name="Events">

                            <%
                                try {
                                    Connection c = connect();
                                    Statement stmt = c.createStatement();
                                    ResultSet rs3 = stmt.executeQuery("SELECT Stockid,Stockname FROM stocdatabase.stock;");
                                    while (rs3.next()) {
                            %>  <option><%out.println(rs3.getString(1));%></option>





                            <%
                                    }

                                } catch (Exception e) {
                                    out.print(e.getMessage());
                                }


                            %>





                        </select>


                    </td>


                </tr>




                <tr>
                    <td><input type="submit" value="Add" name="btnadd"/></td>
                    <td><input type="reset" value="Reset" name="btnreset" /></td>
                </tr>
            </table>


        </form>

        <% if (request.getMethod().equals("POST")) {
                String eusername, epass, Stock;
                String role1 = "";
                String Stocki = "";
                eusername = request.getParameter("eusername");
                epass = request.getParameter("epass");
                Stock = ((String) request.getParameter("Events"));

                session.setAttribute("theName", Stock);
                out.println(session.getAttribute("theName"));
                try {
                    Connection c = connect();
                    Statement stmt = c.createStatement();

                    ResultSet rs3 = stmt.executeQuery("Select username,password,role,Stockid from user where username='" + eusername + "' and password='" + epass + "'");
                    while (rs3.next()) {
                        role1 = rs3.getString(3);
                        request.setAttribute("ssss", role1);
                        Stocki = rs3.getString(4);
                        request.setAttribute("ssss1", Stocki);

                    }

                    // out.println(request.getAttribute("ssss1").toString());
                    out.println(request.getAttribute("ssss").toString());
                    String roleadmin = request.getAttribute("ssss").toString();

                    //   if (request.getAttribute("ssss1").toString().equals("null")) {
                    if (roleadmin.trim().equals("admin")) {
                        response.sendRedirect("index1.jsp");

                    } //}
                    else if (roleadmin.trim().equals("Stock")) {

                        response.sendRedirect("SStock.jsp");

                    } else {
                        out.println("Invalid username or Password");
                    }

                    c.close();

                } catch (Exception e) {
                    out.print(e.getMessage());
                }
            }%>


    </body>
</html>
