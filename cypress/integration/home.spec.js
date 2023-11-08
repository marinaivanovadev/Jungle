
describe('Jungle App', () => {
  beforeEach(() => {
    // Cypress starts with a blank slate for each test
    // Visit the home page before each test

    cy.visit("http://localhost:3000/");
   
  })

  it('displays the home page', () => {
    cy.get(".container").should("exist");
  })
  it("There is products on the page", () => {
      cy.get(".products article").should("be.visible");
  });

  it("There is 12 products on the page", () => {
    
    cy.get(".products article").should("have.length", 12);
  });
})