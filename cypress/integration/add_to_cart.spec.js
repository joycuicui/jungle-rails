describe("add to cart", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("should increase cart count by 1 when clicking 'Add'", () => {
    cy.get(".nav-item").contains("My Cart").should("contain", "0");

    cy.get(".products article")
      .first()
      .within(() => {
        cy.contains("Add").click({ force: true });
      });

    cy.get(".nav-item").contains("My Cart").should("contain", "1");
  });
});
