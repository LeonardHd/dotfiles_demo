---
name: writetests
description: Generate unit tests following best practices and conventions.
argument-hint: Describe what code or functionality needs tests
---
Write unit tests for the specified code following these conventions:

## Test Structure:
- Use the **Arrange, Act, Assert** pattern in all tests
- Arrange: Set up test data and dependencies
- Act: Execute the code under test
- Assert: Verify the expected outcomes

## Framework & Tools:
- Use **pytest** as the test framework
- Use **MagicMock** from `unittest.mock` for creating mock objects
- Use the **@patch** decorator from `unittest.mock` for patching dependencies

## Patching Best Practices:
When using multiple patches, reduce indentation with parenthesized context managers:

```python
with (
    patch.object(SomeClass, "method") as mock_method,
    patch("module.dependency", return_value=mock_value),
):
    # Act & Assert here
```

## Naming Conventions:
- Group files by module
- Test files: `test_<module_name>.py`
- Test functions: `test_<method>_<scenario>_<expected_result>`
- Group related tests into classes named `Test<MethodName>`
- Use descriptive names that explain what is being tested

## Guidelines:
- Test one concept per test function
- Keep tests independent and isolated
- Mock external dependencies, not the code under test
- Include both happy path and edge case tests
