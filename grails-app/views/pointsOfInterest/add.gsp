<html>
  <body>
    <g:form controller="pointsOfInterest" action="add" method="get">
      Name:<input type="text" name="name"/><br/>
      Postcode:<input type="text" name="postcode"/><br/>
      <input type="submit"/>
    </g:form>
    <g:if test="${poi != null}">
      <pre>
        ${poi}
      </pre>
    </g:if>
  </body>
</html>
