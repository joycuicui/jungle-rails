describe("user login", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  // it("should be able to log user in and redirect to home page", () => {
  //   cy.get(".nav-item").contains("Login").click();

  //   cy.url().should("include", "/login");

  //   cy.get("input[name='email']").type(email);
  //   cy.get("input[name='password']").type(password);

  //   cy.get("button[type='submit']").click();

  //   cy.get(".nav-items").contains("Signed In as").should("contain", firstName);
  // });
});
