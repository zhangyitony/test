package test



import org.junit.*
import grails.test.mixin.*

@TestFor(FormController)
@Mock(Form)
class FormControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        params["no"] = '1'
		params["name"] = "chen"
		params["version"] ='2'
    }

    void testIndex() {
        controller.index()
        assert "/form/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.formInstanceList.size() == 0
        assert model.formInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()
		
        assert model.formInstance != null
    }

    void testSave() {
        controller.save()

        assert model.formInstance != null
        assert view == '/form/create'

        response.reset()

        populateValidParams(params)
        controller.save()

		
        assert response.redirectedUrl == '/form/show/1'
        assert controller.flash.message != null
        assert Form.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/form/list'

        populateValidParams(params)
        def form = new Form(params)

        assert form.save() != null

        params.id = form.id

        def model = controller.show()

        assert model.formInstance == form
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/form/list'

        populateValidParams(params)
        def form = new Form(params)

        assert form.save() != null

        params.id = form.id

        def model = controller.edit()

        assert model.formInstance == form
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/form/list'

        response.reset()

        populateValidParams(params)
        def form = new Form(params)

        assert form.save() != null

        // test invalid parameters in update
        params.id = form.id
        //TODO: add invalid values to params object
		params.no='as'
        controller.update()

        assert view == "/form/edit"
        assert model.formInstance != null

        form.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/form/show/$form.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        form.clearErrors()

        populateValidParams(params)
        params.id = form.id
        params.version = -1
        controller.update()

        assert view == "/form/edit"
        assert model.formInstance != null
        assert model.formInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/form/list'

        response.reset()

        populateValidParams(params)
        def form = new Form(params)

        assert form.save() != null
        assert Form.count() == 1

        params.id = form.id

        controller.delete()

        assert Form.count() == 0
        assert Form.get(form.id) == null
        assert response.redirectedUrl == '/form/list'
    }
}
