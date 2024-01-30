describe("product details", () => {
  beforeEach("can visit the homepage", () => {
    cy.visit("/");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("should navigate to the product detail page when clicking on a product", () => {
    cy.get(".products article").first().click();
    cy.url().should("include", "/products/");
    cy.get(".product-detail").should("be.visible");
  });
});
