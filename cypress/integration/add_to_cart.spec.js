describe("Jungle App", () => {
  beforeEach(() => {
    // Cypress starts with a blank slate for each test
    // Visit the home page before each test
    cy.visit("http://127.0.0.1:39623");
  });

  it("displays the home page", () => {
    cy.get(".hero").should("exist");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("adds products to the cart and confirms count update", () => {
    // Select the 'Add to Cart' button for the first product
    cy.get(".products article:first-child").find(".btn").click({ force: true });

    // Confirm that the cart count has increased by 1
    cy.get(".nav-link").contains("My Cart").should("include.text", "(1)");

    
    // Select the 'Add to Cart' button for the second product
    cy.get(".products article:nth-child(2)").find(".btn").click();

    // Confirm that the cart count has increased to 2
    cy.get(".nav-link").contains("My Cart").should("include.text", "(2)");
  });
});
