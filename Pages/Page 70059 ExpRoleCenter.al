profile "Contrôleur"
{
    Description = 'Contrôleur';
    CaptionML = ENU = 'Controler', FRA = 'Contrôleur';
    RoleCenter = 70059;
    //Customizations = SalesLinesCustomizations;
}
page 70059 "ExpRoleCenter"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part("Activités"; 70058)
            {

            }

        }
    }

    actions
    {
        area(Sections)
        {
            group("Réception entrepôt")
            {
                action("Réception achat")
                {
                    RunObject = Page 7332;
                }
                action("Réception achat enregistrées")
                {
                    RunObject = Page 145;
                }
            }
            group("Expéditions")
            {
                action("Expédition ventes")
                {
                    RunObject = Page 7339;
                }
                action("Expédition ventes enregistrées")
                {
                    RunObject = Page 142;
                }
            }
        }
    }
}