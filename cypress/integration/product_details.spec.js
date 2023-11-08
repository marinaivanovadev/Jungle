describe('Jungle App', () => {
  beforeEach(() => {
    // Cypress starts with a blank slate for each test
    // Visit the home page before each test
    cy.visit("http://localhost:3000/");
  })

  it('displays the home page', () => {
    cy.get(".container").should("exist");
  })
  
  it("click one of the product partials in order to navigate directly to a product detail page", () => {
    cy.get(".products article:first-child a").click();

    // Validate that you have been redirected to the product detail page
    cy.url().should("include", "/products/");
    cy.get(".product-detail").should("be.visible");
  });

})