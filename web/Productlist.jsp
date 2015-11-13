
<%@page import="javax.swing.JOptionPane"%>
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
        <title>Product Information</title>
    </head>
    <h1>Product List </h1>

    <%int cout = 0;
        int cout2 = 0;
        int cout3 = 0;int cout4 = 0;

        try {

            Connection c = connect();
            Statement stmt = c.createStatement();
            ResultSet rs = stmt.executeQuery("Select idproduct,productname,productmodel,productQuantity,prix,Rdate from product");

    %> 

    <% while (rs.next()) {%>
    <table border="1" style="width:100%"> <col width="100"> <col width="100"><col width="100"><col width="100"><col width="100"><col width="100">



        <tr>
            <td><%out.println(rs.getString(1));%></td> 
            <td><%out.println(rs.getString(2));%></td> 
            <td><%out.println(rs.getString(3));%></td> 
            <td><%out.println(rs.getString(4));%></td> 
            <td><%out.println(rs.getString(5));%></td>  <td><%out.println(rs.getString(6));%></td>           </tr>


    </table>
    <%  }

            c.close();
        } catch (Exception e) {
        }%>

    <h1>Category List </h1>
    <% try {

            Connection c = connect();
            Statement stmt1 = c.createStatement();
            ResultSet rs1 = stmt1.executeQuery("Select * from category");


    %>

    <%   while (rs1.next()) {%>
    <table border="1" style="width:100%"> <col width="100"> <col width="100"><col width="100">


        <tbody><tr>
                <td><%out.println(rs1.getString(1));%></td> 
                <td><%out.println(rs1.getString(2));%></td> 
                <td><%out.println(rs1.getString(3));%></td> 

            </tr>
        </tbody>
    </table>  
    <%  }

            c.close();
        } catch (Exception e) {
        }%>

    <h1>Stock List</h1>

    <% try {

            Connection c = connect();
            Statement stmt = c.createStatement();
            ResultSet rs = stmt.executeQuery("Select * from stock");

    %>

    <% while (rs.next()) {%>
    <table border="1"style="width:100%"> <col width="100"> <col width="100"><col width="100"><col width="100">



        <tr>
            <td><%out.println(rs.getString(1));%></td> 
            <td><%out.println(rs.getString(2));%></td> 
            <td><%out.println(rs.getString(3));%></td> 
            <td><%out.println(rs.getString(4));%></td> </tr>


    </table>  
    <%  }

            c.close();
        } catch (Exception e) {

        }%>
    <h1>Supplier List </h1>
    <% try {

            Connection c = connect();
            Statement stmt = c.createStatement();
            ResultSet rs = stmt.executeQuery("Select * from supplier");

    %>

    <% while (rs.next()) {%>
    <table border="1" style="width:100%"> <col width="50"> <col width="100"><col width="100"><col width="100"><col width="100">



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




    <h1>Adding New Product</h1>



    <form name="name1" action="#" method="POST">
        <table border="1">


            <tr>
                <td>Product Name</td>
                <td><input type="text" name="pname" value="" size="50" autocomplete="off"/></td>
            </tr>

            <tr>
                <td>Product Model</td>
                <td><input type="text" name="pmodel" value="" size="50" autocomplete="off"/></td>
            </tr>
            <tr>
                <td>Product Quantity</td>
                <td><input type="text" name="pquantity" value="" size="50" autocomplete="off"/></td>
            </tr>

            <tr>
                <td>Prix</td>
                <td><input type="text" name="pprice" value="" size="50" autocomplete="off"/></td>
            </tr>

            <tr>
                <td>Recieved date</td>
                <td><input type="text" name="pdate" value="" size="50" autocomplete="off"/></td>
            </tr>

            <tr>
                <td>Category ID</td>
                <td><input type="text" name="cid" value="" size="50" autocomplete="off"/></td>
            </tr>

            <tr>
                <td>Supplier ID</td>
                <td><input type="text" name="supplierid" value="" size="50" autocomplete="off"/></td>
            </tr> 

            <tr>
                <td>Stock ID</td>
                <td><input type="text" name="stocid" value="" size="50" autocomplete="off"/></td>
            </tr> 

            <tr>
                <td><input type="submit" value="Add" name="btnadd"/></td>
                <td><input type="reset" value="Reset" name="btnreset" /></td>
            </tr>

        </table>
    </form>
    <%
        if (request.getMethod().equals("POST")) {
            String pname, pmodel, pquantity, pprice, pdate, cid, supplierid, stocid;
            pname = request.getParameter("pname");
            pmodel = request.getParameter("pmodel");
            pquantity = request.getParameter("pquantity");
            pprice = request.getParameter("pprice");
            pdate = request.getParameter("pdate");
            cid = request.getParameter("cid");
            supplierid = request.getParameter("supplierid");
            stocid = request.getParameter("stocid");
            try {

                Connection c = connect();
                Statement stmt = c.createStatement();
                ResultSet rs = stmt.executeQuery("Select count(idproduct) ,productQuantity,idproduct from stocdatabase.product where productmodel='" + pmodel + "'");
                while (rs.next()) {
                    cout2 = Integer.parseInt(rs.getString(1));
                    cout3 = Integer.parseInt(rs.getString(2));
                    cout4 = Integer.parseInt(rs.getString(3));
                    request.setAttribute("pmodelexist", cout2);
                    request.setAttribute("pmodelquantity", cout3);
                    request.setAttribute("pid", cout4);
                }
                String modeld = request.getAttribute("pmodelexist").toString();
                String modeld1 = request.getAttribute("pmodelquantity").toString();
                String modeld2 = request.getAttribute("pid").toString();
                int modelq = Integer.parseInt(modeld);
                int modelq2 = Integer.parseInt(modeld2);
                int modelq1=Integer.parseInt(modeld1) +Integer.parseInt(pquantity);
                if (modelq > 0) {
                    out.println(" Model Exist "+ modelq1+"  "+modelq2+" ");
                    
                    String sqlm = "update  stocdatabase.product  set productQuantity=" + modelq1 + " where idproduct=" + modelq2 + "";

                    Statement stmt2 = c.createStatement();
                    stmt2.executeUpdate(sqlm);

                } else if (modelq == 0) {
                    String sql = "insert into stocdatabase.product(catfk,productname,productmodel,Rdate,productQuantity,prix)  values (" + cid + ",'" + pname + "','" + pmodel + "','" + pdate + "'," + pquantity + "," + pprice + ")";
                    Statement stmt1 = c.createStatement();

                    stmt1.executeUpdate(sql);
                
                Statement stmt3 = c.createStatement();
                ResultSet rs3 = stmt3.executeQuery("Select count(idproduct) from stocdatabase.product");

                while (rs3.next()) {
                    cout = Integer.parseInt(rs3.getString(1));
                    request.setAttribute("ssss", cout);

                }
                String sssdw = request.getAttribute("ssss").toString();
                int sedaserqw = Integer.parseInt(sssdw);
                out.println(sedaserqw);

                out.println(stocid);

                String sql121 = "insert into stocdatabase.stocpro(Stocid,prodid1)  values (" + stocid + "," + sssdw + ")";

                Statement stmt2 = c.createStatement();
                stmt2.executeUpdate(sql121);

                String sql2 = "insert into stocdatabase.supprod(idsup,idprod)  values (" + supplierid + "," + sssdw + ")";
                Statement stmt5 = c.createStatement();
                stmt5.executeUpdate(sql2);
                }
                c.close();

            } catch (Exception e) {
                out.print(e.getMessage());
            }
        }

    %>        
















</html>
